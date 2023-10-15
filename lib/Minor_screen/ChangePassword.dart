import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../auth/Auth_repository.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  static const String id = 'forget_email_screen';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordScreen> {
  late String email;
  late String password;
  bool _obscureText = true;
  bool checkPassword = true;
  bool processing = false;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _NewPasswordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffaec2fa),
              Color(0xffb6e6c5),
            ]),
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/9,),
              Align(
                alignment: AlignmentDirectional(0, 0.65),
                child: Icon(
                  Icons.change_circle,
                  color: Colors.black,
                  size: 180,
                ),
              ),
              Text(
                'Change Password\n',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 29,
                  color: Colors.black,
                ),
              ),
              Text(
                'Please Fill all the below Fields \n      change your password',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 19,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formkey,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _oldPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Current Password';
                        } else
                          return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          hintText: 'Enter old Password',
                          labelText: 'Old Password',
                          errorText: checkPassword != true
                              ? 'Not Valid Current Password'
                              : null,
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon:
                              Icon(Icons.fingerprint_sharp, color: Colors.black),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextFormField(
                      controller: _NewPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your New Password';
                        } else
                          return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          hintText: 'Enter New Password',
                          labelText: 'New Password',
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon:
                              Icon(Icons.fingerprint_sharp, color: Colors.black),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value != _NewPasswordController.text) {
                          return 'Password Not Matching  ';
                        } else if (value!.isEmpty) {
                          return 'Re-Enter New Password';
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          labelText: 'Confirm Password',
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon:
                              Icon(Icons.fingerprint_sharp, color: Colors.black),
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
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              FlutterPwValidator(
                successColor: Colors.white,
                defaultColor: Colors.black,
                controller: _NewPasswordController,
                minLength: 6,
                uppercaseCharCount: 1,
                numericCharCount: 2,
                specialCharCount: 1,
                width: MediaQuery.of(context).size.width*.90,
                height: 150,
                onSuccess: () {},
                onFail: () {},
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.02
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shadowColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () async {
                    setState(() {
                      processing = true;
                    });
                    if (_formkey.currentState!.validate()) {
                      checkPassword = await Auth.checkOldPassword(
                          FirebaseAuth.instance.currentUser!.email,
                          _oldPasswordController.text);
                      setState(() {});
                      checkPassword == true
                          ? FirebaseAuth.instance.currentUser!
                              .updatePassword(_NewPasswordController.text)
                              .whenComplete(() {
                              _formkey.currentState!.reset();
                              _NewPasswordController.clear();
                              _oldPasswordController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: new Text("Password is matched")));
                              Future.delayed(const Duration(seconds: 1))
                                  .whenComplete(() {
                                setState(() {
                                  processing = false;
                                });
                                Navigator.pop(context);
                              });
                            })
                          : print("Not valid Old password");
                      print('Valid');
                    } else {
                      print("invalid");
                      setState(() {
                        processing = false;
                      });
                    }
                  },
                  child: Container(
                    //margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: processing == true
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Save Changes',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(Colors.black),
              //     shadowColor: MaterialStateProperty.all(Colors.white),
              //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //     ),
              //   ),
              //   onPressed: () async {
              //     if (_formkey.currentState!.validate()) {
              //       checkPassword = await Auth.checkOldPassword(
              //           FirebaseAuth.instance.currentUser!.email,
              //           _oldPasswordController.text);
              //       setState(() {});
              //       checkPassword == true
              //           ? FirebaseAuth.instance.currentUser!
              //               .updatePassword(_NewPasswordController.text)
              //               .whenComplete(() {
              //               _formkey.currentState!.reset();
              //               _NewPasswordController.clear();
              //               _oldPasswordController.clear();
              //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //                   content: new Text("Password is matched")));
              //               Future.delayed(const Duration(seconds: 1))
              //                   .whenComplete(() {
              //                 Navigator.pop(context);
              //               });
              //             })
              //           : print("Not valid Old password");
              //       print('Valid');
              //     } else {
              //       print("invalid");
              //     }
              //   },
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 110, vertical: 15),
              //     child: Text(
              //       'Save Changes',
              //       style: TextStyle(fontSize: 24, color: Colors.white),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
