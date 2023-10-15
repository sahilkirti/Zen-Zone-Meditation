import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'PhoneVerification.dart';

class OtpScreen extends StatefulWidget{
  final String verificationId;
  OtpScreen({Key? key,required this.verificationId}):super(key: key);
  @override
  State<OtpScreen> createState() =>_OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();

  void verifyOtp() async{
    String otp = otpController.text.trim();
    PhoneAuthCredential credential=PhoneAuthProvider.credential
      (verificationId: widget.verificationId, smsCode: otp);
    try{
      UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
      if(userCredential!=null){
        Navigator.popUntil(context,(route)=>route.isFirst);
        //Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>const MyHomePage(title:'HomePage')));
      }
    } on FirebaseAuthException catch(ex) {
      //  log(ex.code.toString());
      const snackBar = SnackBar(
        content: Text('invalid otp!'),
        backgroundColor: Colors.pink,
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>const SignWithPhone()));},
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
        ),

      ),
      body: Container(
        margin:const EdgeInsets.only(left:24,right: 24 ),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children:[
              Image.network('https://img.freepik.com/free-vector/sign-concept-illustration_114360-125.jpg?w=1800&t=st=1681147870~exp=1681148470~hmac=a4e190b3484c70642b180d8586bc31478aa3f7aded4319775bcb85a83ffbbb4c',height: 200,width: 200,),
              const SizedBox(height: 5,),
              const Text('Phone Verification',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
              const SizedBox(height: 6,),
              const Text('Verification code sent to your mobile number',style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,),
              const SizedBox(height:20 ),
              Pinput(
                length: 6,
                controller: otpController,
              ),
              const SizedBox(height: 20,),

              SizedBox(
                width: double.infinity,
                height:50 ,
                child: ElevatedButton(
                  onPressed: (){
                    verifyOtp();
                  },
                  style: ElevatedButton.styleFrom(shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ) ),
                  child:const Text('Verify phone number',style:TextStyle(fontSize: 18) ,),
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>const SignWithPhone(),));},
                      child: const Text('Edit Phone Number?',style: TextStyle(color: Colors.black),)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}