import 'package:final2/Screens/CustomerHomeScreen.dart';
import 'package:final2/Screens/Welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Screens/OnBoarding1.dart';

class JunctionScreen extends StatelessWidget {
      static const  String  id='junctionScreen';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();

          }
          else if(snapshot.hasData){
            return CustomerHomeScreen();
          }
          else {
            return onBoarding();
          }
        }
    );
  }
}
