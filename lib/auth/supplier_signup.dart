import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/auth/supplier_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../Minor_screen/ForgetEmail.dart';

// final TextEditingController _namecontroller = TextEditingController();
// final TextEditingController _emailcontroller = TextEditingController();
// final TextEditingController _phonecontroller = TextEditingController();
// final TextEditingController _passwordcontroller = TextEditingController();

final _firestore = FirebaseFirestore.instance;

class SupplierSignUpScreen extends StatefulWidget {
  const SupplierSignUpScreen({Key? key}) : super(key: key);
  static const String id = '/Supplier_Signup_screen';

  @override
  State<SupplierSignUpScreen> createState() => _SupplierSignUpScreenState();
}

class _SupplierSignUpScreenState extends State<SupplierSignUpScreen> {
  late String name;
  late String email;
  late String phone;
  late String password;
  late String profileImage;
  late String _uid;
  bool processing = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  dynamic _pickImageError;
  bool _phoneExist = false;

  //
  // CollectionReference suppliers =
  // _firestore.collection('suppliers');

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 96,
      );
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
      print(_pickImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 96,
      );
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
      print(_pickImageError);
    }
  }

  void signUp() async {
    setState(() {
      processing = true;
    });
    if (_formkey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          try {
            await FirebaseAuth.instance.currentUser!.sendEmailVerification();
          } catch (e) {
            print(e);
          }


          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('supp-image/$email.jpg');
          await ref.putFile(File(_imageFile!.path));
          _uid = FirebaseAuth.instance.currentUser!.uid;
          profileImage = await ref.getDownloadURL();

          await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
          await FirebaseAuth.instance.currentUser!.updatePhotoURL(profileImage);

          await _firestore.collection('suppliers').doc(_uid).set({
            'name': name,
            'email': email,
            'profileimage': profileImage,
            'phone': phone,
            'address': '',
            'sid': _uid
          });
          _formkey.currentState!.reset();
          setState(() {
            _imageFile = null;
          });
          Navigator.pushReplacementNamed(context, SupplierloginScreen.id);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            setState(() {
              processing = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'On Snap!',
                message: 'This password in too weak',
                contentType: ContentType.failure,
              ),
            ));
          } else if (e.code == 'email-already-in-use') {
            setState(() {
              processing = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'On Snap!',
                message: 'This account already exists for that email',
                contentType: ContentType.failure,
              ),
            ));
          }
        }
      } else {
        setState(() {
          processing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'You should also pick Image',
            contentType: ContentType.failure,
          ),
        ));
      }
    } else {
      setState(() {
        processing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: 'Please Enter all the above fields correctly',
          contentType: ContentType.failure,
        ),
      ));

      //Navigator.pushReplacementNamed(context, '/Customer_screen');
    }
  }

  void checkPhoneNo(String phoneNumber) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('customer')
        .where('phone', isEqualTo: phoneNumber)
        .get();
    setState(() {
      _phoneExist = snapshot.docs.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Stack(children: [
              Column(
                children: [
                  Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text('Sign-Up',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 28,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 50,
                        backgroundImage: _imageFile == null
                            ? null
                            : FileImage(File(_imageFile!.path)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              _pickImageFromCamera();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5))),
                              child: Icon(
                                Icons.camera,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              _pickImageFromGallery();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                    SizedBox(
                      height: 15,
                    ),
                  ]),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            onChanged: (value) {
                              name = value;
                            },
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Full Name';
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Full Name',
                                labelText: 'Full Name',
                                floatingLabelStyle:
                                TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                    BorderSide(color: Colors.black , width: 2)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                    BorderSide(color: Colors.black , width: 2)),
                                prefixIcon: Icon(
                                  Icons.person_2_outlined,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            onChanged: (value) {
                              email = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Email';
                              } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value)) {
                                return 'Invalid Email';
                              } else if (RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value)) {
                                return null;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Email Address',
                                labelText: 'Email',
                                floatingLabelStyle:
                                TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                    BorderSide(color: Colors.black , width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                    BorderSide(color: Colors.black , width: 2)),
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Colors.black),
                                suffixIconColor: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            onChanged: (value) {
                              phone = value;
                            },
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Phone No';
                              }
                              if (value.length != 10) {
                                return 'Mobile Number must be of 10 digit';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Phone No',
                                labelText: 'Phone No',
                                floatingLabelStyle:
                                TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                    BorderSide(color: Colors.black , width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                    BorderSide(color: Colors.black , width: 2)),
                                prefixIcon:
                                Icon(Icons.phone, color: Colors.black),
                                suffixIconColor: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            onChanged: (value) {
                              password = value;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Password';
                              } else
                                return null;
                            },
                            obscureText: _obscureText,
                            maxLength: 30,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                floatingLabelStyle:
                                TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                    BorderSide(color: Colors.black , width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                    BorderSide(color: Colors.black , width: 2)),
                                prefixIcon: Icon(Icons.fingerprint_sharp,
                                    color: Colors.black),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      Scaffold(
                                        backgroundColor: Colors.black,
                                        body: Container(
                                          padding: EdgeInsets.all(40),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Make Selection!',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30),
                                              ),
                                              Text(
                                                'Select one of the option given below to reset your password',
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => forget()));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    color: Colors.grey[400],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .mail_outline_outlined,
                                                          size: 50),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            'E-mail',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                            'Reset via Mail Verification',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontSize: 15),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    color: Colors.grey[400],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .mobile_friendly_sharp,
                                                          size: 50),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            'Phone',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                            'Reset via Phone Verification',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontSize: 15),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                );
                              },
                              child: Text(
                                'Forget Password?',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side:
                                  BorderSide(color: Colors.black, width: 2),
                                ),
                              ),
                            ),
                            onPressed: () {
                              signUp();
                            },
                            child: Container(
                              //margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: processing == true
                                    ? const CircularProgressIndicator(
                                  color: Colors.black,
                                )
                                    : Text(
                                  'Sign - Up',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 24,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'OR',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Container(
                            height: MediaQuery.of(context).size.height / 15,
                            width: MediaQuery.of(context).size.width,
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
                                Icon(FontAwesomeIcons.google),
                                SizedBox(
                                  width: 10,
                                ),
                                Center(
                                  child: Text(
                                    "Sign-In With Google",
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Container(
                            height: MediaQuery.of(context).size.height / 15,
                            width: MediaQuery.of(context).size.width,
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
                                Icon(FontAwesomeIcons.apple, size: 30),
                                SizedBox(
                                  width: 10,
                                ),
                                Center(
                                  child: Text(
                                    "Sign-In With Apple-Id",
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, SupplierloginScreen.id);
                        },
                        child: Text(
                          'Already have an Account?',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
