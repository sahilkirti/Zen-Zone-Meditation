import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forget extends StatefulWidget {
  const forget({Key? key}) : super(key: key);
  static const String id = 'forget_email_screen';
  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  late String email;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff36CD21),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 397.2,
              height: 370,
              decoration: BoxDecoration(
                color: Color(0xFF37CC21),
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0.65),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.black,
                  size: 180,
                ),
              ),
            ),
            Text(
              'Forget Password\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 29,
                color: Colors.black,
              ),
            ),
            Text(
              'Please Enter your Email Address to \n             reset your password',
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
              child: Padding(
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
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon:
                          Icon(Icons.email_outlined, color: Colors.black),
                      suffixIconColor: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                shadowColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              onPressed: () async {
                if (_formkey.currentState!.validate())
                {
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email);
                  } catch (e) {
                    print(e);
                  }
                }
                else
                  {
                    print('Email not Valid ');
                  }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 158, vertical: 15),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
