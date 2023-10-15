import 'dart:ui';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 1000  , sigmaX: 1000),
        child: Stack(children: [
          SingleChildScrollView(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100 , sigmaY: 1000),
              child: SafeArea(
                child: Center(
                  child: Stack(children: [
                    Column(
                      children: [
                        Column(children: [
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: Text('Welcome-Back',
                                style: GoogleFonts.abyssinicaSil(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 28,
                                    color: Colors.black)),
                          ),
                          Icon(
                            Icons.account_circle_sharp,
                            size: 200,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ]),
                        Container(
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: TextFormField(
                                    onChanged: (value)
                                    {
                                      email = value;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Your Email';
                                      } else if (value.isValidEmail() == false) {
                                        return 'Invalid Email';
                                      } else if (value.isValidEmail() == true) {
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
                                                BorderSide(color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:
                                                BorderSide(color: Colors.black)),
                                        prefixIcon: Icon(Icons.email_outlined,
                                            color: Colors.black),
                                        suffixIconColor: Colors.grey),
                                  ),
                                ),
                                SizedBox(height: 15),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: TextFormField(
                                    onChanged: (value)
                                    {
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
                                                BorderSide(color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:
                                                BorderSide(color: Colors.black)),
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
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      padding: EdgeInsets.all(20),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
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
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 15),
                                                              ),
                                                              Text(
                                                                'Reset via Mail Verification',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
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
                                                            BorderRadius.circular(
                                                                10),
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
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 15),
                                                              ),
                                                              Text(
                                                                'Reset via Phone Verification',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
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
                                          MaterialStateProperty.all(Colors.black),
                                      shadowColor:
                                          MaterialStateProperty.all(Colors.white),
                                    ),
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        print('Valid');
                                        setState(() {

                                        });
                                        print(email);
                                        print(password);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: 'On Snap!',
                                            message:
                                                'Please Enter all the above fields',
                                            contentType: ContentType.failure,
                                          ),
                                        ));
                                      }
                                    },
                                    child: Container(
                                      //margin: EdgeInsets.symmetric(horizontal: 20),
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 24,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
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
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.black,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 63,
                                child: OutlinedButton.icon(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(200)))),
                                  icon: Image(
                                    image: AssetImage(
                                        'images/loginandsignup/Google_logo.png'),
                                    width: 30,
                                  ),
                                  onPressed: () {},
                                  label: Text(
                                    'Sign-In with Google',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.black,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 63,
                                child: OutlinedButton.icon(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(200)))),
                                  icon: Image(
                                    image: AssetImage(
                                        'images/loginandsignup/iphone.png'),
                                    width: 30,
                                  ),
                                  onPressed: () {},
                                  label: Text(
                                    'Sign-In with Apple-Id',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
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
                                    context, '/Customer_register_screen');
                              },
                              child: Text(
                                'Don\'t have an Account?',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
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
          ),
        ]),
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
