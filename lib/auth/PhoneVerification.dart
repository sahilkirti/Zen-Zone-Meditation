import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'OtpScreen.dart';

class SignWithPhone extends StatefulWidget
{
  const SignWithPhone({Key? key}):super(key: key);
  @override
  State<SignWithPhone>createState()=>_SignWithPhone();
}

class _SignWithPhone extends State<SignWithPhone>
{
  TextEditingController countryCode=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  @override
  void initState(){
    countryCode.text="+91";
    super.initState();
  }
  void sendOtp() async {
    String phone = countryCode.text +phoneController.text.trim();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, resendToken) {
          Navigator.push(context,MaterialPageRoute(builder: (context)=> OtpScreen(verificationId: verificationId,),
          ));
        },
        verificationCompleted: (credential) {},
        verificationFailed: (ex) {
          // log(ex.code.toString());
          const snackBar = SnackBar(
            content: Text('Verification failed!'),
            backgroundColor: Colors.pink,
            duration: Duration(seconds: 5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        //duration
        timeout:Duration(seconds: 60)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 24, right: 24),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                'https://img.freepik.com/free-vector/sign-concept-illustration_114360-125.jpg?w=1800&t=st=1681147870~exp=1681148470~hmac=a4e190b3484c70642b180d8586bc31478aa3f7aded4319775bcb85a83ffbbb4c',
                height: 200, width: 200,),
              const SizedBox(height: 5,),
              const Text('Phone Verification',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
              const SizedBox(height: 6,),
              const Text('We need to register your phone before get started!',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryCode,
                        decoration: const InputDecoration(
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    const Text(
                      '|', style: TextStyle(fontSize: 34, color: Colors.grey),),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        decoration: const InputDecoration(
                            hintText: 'Enter Phone Number',
                            border: InputBorder.none
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    sendOtp();
                  },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )),
                  child: const Text(
                    'Send the code', style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
