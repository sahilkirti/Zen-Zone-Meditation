import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditAudio extends StatefulWidget {
  final dynamic data;

  const EditAudio({Key? key, this.data}) : super(key: key);

  @override
  State<EditAudio> createState() => _EditAudioState();
}

class _EditAudioState extends State<EditAudio> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  XFile? imageFileLogo;
  XFile? imageFileCover;
  dynamic _pickedImageError;
  late String SupplierName;
  late String phone;
  late String profileimage;
  late String coverImage;
  bool processing = false;
  final ImagePicker _picker = ImagePicker();

  pickSupplierLogo() async {
    try {
      final pickedStoreLogo = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileLogo = pickedStoreLogo;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Future uploadSupplierLogo() async {
    if (imageFileLogo != null) {
      try {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('supp-images/${widget.data['email']}.jpg');

        await ref.putFile(File(imageFileLogo!.path));

        profileimage = await ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      profileimage = widget.data['profileimage'];
    }
  }

  editSupplierData() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('suppliers')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      transaction.update(documentReference, {
        'name': SupplierName,
        'phone': phone,
        'profileimage': profileimage,
      });
    }).whenComplete(() => Navigator.pop(context));
  }

  saveChanges() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        processing = true;
      });
      await uploadSupplierLogo().whenComplete(() => editSupplierData());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: 'Please Supply all the field',
          contentType: ContentType.failure,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                )),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Edit Audio Product',
              style:
                  GoogleFonts.abyssinicaSil(fontSize: 24, color: Colors.black),
            )),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                'Supplier Logo',
                style: GoogleFonts.abyssinicaSil(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  imageFileLogo == null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(widget.data['profileimage']),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(File(imageFileLogo!.path)),
                        ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(24, 10, 14, 10),
                        child: InkWell(
                          onTap: () {
                            pickSupplierLogo();
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xffb2d5dd),
                                  Color(0xffb7dfce),
                                  Color(0xffafc2f9),
                                ]),
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Change",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.abyssinicaSil(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      imageFileLogo == null
                          ? SizedBox()
                          : Padding(
                              padding: EdgeInsets.fromLTRB(24, 0, 14, 10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    imageFileLogo = null;
                                  });
                                },
                                child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xffb2d5dd),
                                        Color(0xffb7dfce),
                                        Color(0xffafc2f9),
                                      ]),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            "Reset",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.abyssinicaSil(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 24,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                    ],
                  )
                ],
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 23, right: 23, top: 10),
                child: TextFormField(
                  initialValue: widget.data['name'],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please Enter Supplier name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    SupplierName = value!;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Supplier Name',
                      labelText: 'Supplier Name',
                      focusColor: Colors.black,
                      enabled: true,
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      prefixIcon: Icon(Icons.account_circle_outlined,
                          color: Colors.black),
                      suffixIconColor: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 23, right: 23, top: 10),
                child: TextFormField(
                  initialValue: widget.data['phone'],
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please Enter Supplier Phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phone = value!;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      labelText: 'Supplier Phone Number',
                      focusColor: Colors.black,
                      enabled: true,
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      prefixIcon: Icon(Icons.account_circle_outlined,
                          color: Colors.black),
                      suffixIconColor: Colors.black),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, 10, 14, 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height / 20,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xffb2d5dd),
                              Color(0xffb7dfce),
                              Color(0xffafc2f9),
                            ]),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Cancel",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.abyssinicaSil(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
                      child: processing == true
                          ? Container(
                              height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xffb2d5dd),
                                  Color(0xffb7dfce),
                                  Color(0xffafc2f9),
                                ]),
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Please Wait ...",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.abyssinicaSil(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ))
                          : GestureDetector(
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xffb2d5dd),
                                      Color(0xffb7dfce),
                                      Color(0xffafc2f9),
                                    ]),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Save Changes",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.abyssinicaSil(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 24,
                                              color: Colors.black),
                                        ),
                                      )
                                    ],
                                  )),
                              onTap: () {
                                saveChanges();
                              },
                            )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
