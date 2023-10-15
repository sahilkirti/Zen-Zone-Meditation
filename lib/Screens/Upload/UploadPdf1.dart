import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../Utilities/Category.dart';
import 'Upload.dart';
import 'Upload_product.dart';
import 'package:file_picker/file_picker.dart';

File? file;

class UploadBook1 extends StatefulWidget {
  const UploadBook1({Key? key}) : super(key: key);
  static const String id = '/Upload_pdf_screen';
  @override
  State<UploadBook1> createState() => _UploadBookState();
}

class _UploadBookState extends State<UploadBook1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late double BookPrice;
  late String BookName;
  late String BookDesc;
  late String BookId;
  late String url;
  late String BookAuthor;
  String mainCategValue = 'Self Help';
  bool processing = false;
  List<XFile>? _imageFileList = [];
  List<String> _imageUrlList = [];
  List<XFile>? _pdfFileList = [];
  dynamic _pickImageError;
  bool isdelete = false;
  UploadTask? task;

  void _pickProductImages() async {
    try {
      final pickedImages = await ImagePicker().pickMultiImage(
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 96,
      );
      setState(() {
        _imageFileList = pickedImages!;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
      print(_pickImageError);
    }
  }

  Widget previewImages() {
    if (_imageFileList!.isNotEmpty) {
      return ListView.builder(
          itemCount: _imageFileList!.length,
          itemBuilder: (context, index) {
            return Image.file(File(_imageFileList![index].path));
          });
    } else {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Center(
          child: Text('You have not \n picked any Book Image yet!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal)),
        ),
        SizedBox(
          height: 5,
        ),
        Icon(
          Icons.image,
          size: 35,
        )
      ]);
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false , allowedExtensions: ['pdf', 'doc'], type: FileType.custom);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;
    final fileName = path.basename(file!.path);
    final destination = 'Book-Pdf/$fileName';
    task = FirebaseApi.uploadFile(destination, file!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    String Url = await snapshot.ref.getDownloadURL();
  }

  Future uploadPdf() async{
    if (file == null) return;
    setState(() {
      processing = true;
    });
    final fileName = path.basename(file!.path);
    final destination = 'Book-Pdf/$fileName';
    var pdfFile = FirebaseStorage.instance.ref(destination);
    firebase_storage.UploadTask task = pdfFile.putFile(file!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );

  Future<void> uploadImages() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_imageFileList!.isNotEmpty) {
        setState(() {
          processing = true;
        });
        try {
          for (var image in _imageFileList!) {
            firebase_storage.Reference ref = firebase_storage
                .FirebaseStorage.instance
                .ref('Book_Image/${path.basename(image.path)}');
            await ref.putFile(File(image.path)).whenComplete(() async {
              await ref.getDownloadURL().then((value) {
                _imageUrlList.add(value);
              });
            });
          }
        } catch (e) {
          print(e);
        }
        setState(() {
          _imageFileList = [];
        });
        _formKey.currentState!.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'Please pick Book images first',
            contentType: ContentType.failure,
          ),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: 'Please Enter all the fields Properly',
          contentType: ContentType.failure,
        ),
      ));
    }
  }

  void uploadData() async {
    if (_imageUrlList.isNotEmpty) {
      CollectionReference productRef =
      FirebaseFirestore.instance.collection('Book_detail');
      BookId = const Uuid().v4();
      await productRef.doc(BookId).set({
        'Bookid': BookId,
        'Bookprice': BookPrice,
        'Bookname': BookName,
        'Bookdesc': BookDesc,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'Bookimages': _imageUrlList,
        'discount': 0,
        'BookAuthor' : BookAuthor,
        'BookUrl': url,
        'BookCategory' : mainCategValue
      }).whenComplete(() {
        setState(() {
          processing = false;
          _imageFileList = [];
          _imageUrlList = [];
        });
        _formKey.currentState!.reset();
      });
    } else {
      print('No Images');
    }
  }

  void uploadProduct() async {
    await uploadPdf().then((value) => uploadImages()).whenComplete(() {
      uploadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var filename = file != null ? path.basename(file!.path) : 'No pdf Selected';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Upload Book',
          style: GoogleFonts.abyssinicaSil(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 2,
                ),
                Row(children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5-7,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.20),
                    child: Column(
                      children: [
                        const Text("Select Category"),
                        DropdownButton(
                            iconSize: 40,
                            borderRadius: BorderRadius.circular(5),
                            enableFeedback: true,
                            elevation: 0,
                            focusColor: Colors.black,
                            dropdownColor: Colors.grey,
                            menuMaxHeight: 500,
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              size: 30,
                            ),
                            disabledHint: const Text('select category'),
                            value: mainCategValue,
                            items: BookCategory
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                mainCategValue = value!;
                              });
                            })
                      ],
                    ),
                  ),
                  Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: _imageFileList != null
                          ? previewImages()
                          : const Center(
                        child: Text(
                            'You have not \n \n picked any Book Image yet!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey)),
                      ),
                    ),
                    _imageFileList!.isEmpty
                        ? const SizedBox()
                        : IconButton(
                        onPressed: () {
                          setState(() {
                            _imageFileList = [];
                          });
                        },
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.black,
                        )),
                  ]),
                ],),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Book Price";
                      } else if (value.isValidPrice() != true) {
                        return 'Invalid Price';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      BookPrice = double.parse(value!);
                    },
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    decoration: textFormDecoration.copyWith(
                        hintText: 'Enter a price for a Book',
                        labelText: 'Book Price',
                        prefixIcon: Icon(
                          Icons.currency_rupee,
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Book Name";
                      }
                      return null;
                    },
                    maxLength: 100,
                    maxLines: 2,
                    onSaved: (value) {
                      BookName = value!;
                    },
                    decoration: textFormDecoration.copyWith(
                        hintText: 'Enter Book Name',
                        labelText: 'Book Name',
                        prefixIcon: Icon(
                          Icons.drive_file_rename_outline_sharp,
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Author Name";
                      }
                      return null;
                    },
                    maxLength: 100,
                    maxLines: 2,
                    onSaved: (value) {
                      BookAuthor = value!;
                    },
                    decoration: textFormDecoration.copyWith(
                        hintText: 'Enter Author Name',
                        labelText: 'Author Name',
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Book Description";
                      }
                      return null;
                    },
                    maxLength: 800,
                    maxLines: 5,
                    onSaved: (value) {
                      BookDesc = value!;
                    },
                    decoration: textFormDecoration.copyWith(
                        hintText: 'Book Description',
                        labelText: 'Book Description',
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.black,
                        )),
                  ),
                ),
                // Stack(children: [
                //   Container(
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(5),
                //         border: Border.all(color: Colors.grey)),
                //     height: MediaQuery.of(context).size.width * 0.5,
                //     width: MediaQuery.of(context).size.width * 0.90,
                //     child: _imageFileList != null
                //         ? previewImages()
                //         : const Center(
                //       child: Text(
                //           'You have not \n \n picked any Book Image yet!',
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //               fontSize: 16, color: Colors.grey)),
                //     ),
                //   ),
                //   _imageFileList!.isEmpty
                //       ? const SizedBox()
                //       : IconButton(
                //       onPressed: () {
                //         setState(() {
                //           _imageFileList = [];
                //         });
                //       },
                //       icon: Icon(
                //         Icons.delete_forever_outlined,
                //         color: Colors.black,
                //       )),
                // ]),
                // SizedBox(
                //   height: 20,
                // ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ButtonWidget(
                          text: 'Select Pdf',
                          icon: Icons.attach_file,
                          onClicked: selectFile,
                        ),
                        SizedBox(height: 8),
                        Text(
                          filename,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 15),
                        // ButtonWidget(
                        //   text: 'Upload File',
                        //   icon: Icons.cloud_upload_outlined,
                        //   onClicked: uploadFile,
                        // ),
                        // SizedBox(height: 15),
                        task != null ? buildUploadStatus(task!) : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _imageFileList!.isEmpty
              ? SizedBox()
              : Padding(
            padding: EdgeInsets.only(right: 10),
            child: FloatingActionButton(
              mouseCursor: MaterialStateMouseCursor.clickable,
              onPressed: () {
                _pickProductImages();
              },
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: FloatingActionButton(
              mouseCursor: MaterialStateMouseCursor.clickable,
              onPressed: () {
                _pickProductImages();
              },
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.photo_library,
                color: Colors.white,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: processing == true
                ? null
                : ()  {
              uploadProduct();
              setState(() {
                isdelete = true;
              });
            },
            backgroundColor: Colors.black,
            child: processing == true
                ? CircularProgressIndicator(
              color: Colors.white,
            )
                : const Icon(
              Icons.upload,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Color.fromRGBO(29, 194, 95, 1),
      minimumSize: Size.fromHeight(50),
    ),
    child: buildContent(),
    onPressed: onClicked,
  );

  Widget buildContent() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 28),
      SizedBox(width: 16),
      Text(
        text,
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    ],
  );
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}