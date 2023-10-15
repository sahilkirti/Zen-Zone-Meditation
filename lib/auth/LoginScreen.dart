import 'dart:ui';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/auth/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Chat2/DatabaseServices.dart';
import '../Chat2/Helper.dart';
import '../Minor_screen/ForgetEmail.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);
  static const String id = '/Customer_login_screen';

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  CollectionReference customer =
      FirebaseFirestore.instance.collection('customer');

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var doc = await customer.doc(docId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  bool docExists = false;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .whenComplete(() async {
      User user = FirebaseAuth.instance.currentUser!;
      print(googleUser!.id);
      print(FirebaseAuth.instance.currentUser!.uid);
      print(googleUser);
      print(user);

      docExists = await checkIfDocExists(user.uid);

      docExists == false
          ? await customer.doc(user.uid).set({
              'name': user.displayName,
              'email': user.email,
              'profileimage': user.photoURL,
              'phone': '',
              'address': '',
              'cid': user.uid,
            }).then((value) => Navigator.pushNamed(context, '/Customer_screen'))
          : Navigator.pushNamed(context, '/Customer_screen');
    });
  }

  late String email;
  late String password;
  bool processing = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool sendEmailVerification = false;

  void logIn() async {
    setState(() {
      processing = true;
    });
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password).then((value) async{
          if(value != null){
            QuerySnapshot snapshot =
            await DatabaseService(sid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(email);
            await HelperFunctions.saveUserLoggedInStatus(true);
            await HelperFunctions.saveUserNameSF(snapshot.docs[0]['name']);
            await HelperFunctions.saveUserEmailSF(email);

          }
        });
        await FirebaseAuth.instance.currentUser!.reload();
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          _formkey.currentState!.reset();
          Navigator.pushReplacementNamed(context, '/Customer_screen');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'On Snap!',
                message: 'Please Check Your Email Inbox',
                contentType: ContentType.failure,
              ),
            ),
          );
          setState(() {
            processing = false;
            sendEmailVerification = true;
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            processing = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'On Snap!',
                message:
                'No user found for that Email , Please check once again !',
                contentType: ContentType.failure,
              ),
            ),
          );
        } else if (e.code == 'wrong-password') {
          setState(() {
            processing = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'On Snap!',
                message: 'Wrong password , Please enter again !',
                contentType: ContentType.failure,
              ),
            ),
          );
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
          message: 'Please Enter all the above fields',
          contentType: ContentType.failure,
        ),
      ));

      //Navigator.pushReplacementNamed(context, '/Customer_screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: SafeArea(
          child: Center(
            child: Stack(children: [
              // Container(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.transparent,
              //   child: Image.asset(
              //     'images/Blur/blur4.jpeg',
              //     fit: BoxFit.cover,
              //   ),
              // ),
              // Positioned.fill(child: BackdropFilter(
              //   filter: ImageFilter.blur(sigmaX : 1000 , sigmaY: 1000),
              //   child: SizedBox(),
              // )),
              Column(
                children: [
                  Column(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 010),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black, width: 2),
                            image: DecorationImage(
                                image: AssetImage('images/Blur/Login.jpg'))),
                      ),
                    )
                  ]),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
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
                                focusColor: Colors.black,
                                enabled: true,
                                floatingLabelStyle:
                                    TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Colors.black),
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
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
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
                                  builder: (context) => Scaffold(
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
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 50,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          forget()));
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
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        'Reset via Mail Verification',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        'Reset via Phone Verification',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                              logIn();
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
                                        'Login',
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
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: InkWell(
                          onTap: () {
                            signInWithGoogle();
                          },
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
                                border:
                                    Border.all(color: Colors.black, width: 2),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, SignUpScreen.id);
                        },
                        child: Text(
                          'Don\'t have an Account?',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: sendEmailVerification == true
                            ? InkWell(
                                onTap: () async {
                                  try {
                                    await FirebaseAuth.instance.currentUser!
                                        .sendEmailVerification();
                                  } catch (e) {
                                    print(e);
                                  }
                                  Future.delayed(Duration(seconds: 3))
                                      .whenComplete(() {
                                    setState(() {
                                      sendEmailVerification = false;
                                    });
                                  });
                                },
                                child: Text(
                                  'Send the Verification Code Again',
                                  style: GoogleFonts.abyssinicaSil(
                                      color: Colors.blueAccent,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w300),
                                ),
                              )
                            : SizedBox(),
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
