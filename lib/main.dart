import 'dart:ui';
import 'package:final2/Minor_screen/ChangePassword.dart';
import 'package:final2/Screens/Explore.dart';
import 'package:final2/Screens/Home.dart';
import 'package:final2/Stripe/Stripe_id.dart';
import 'package:final2/auth/LoginScreen.dart';
import 'package:final2/Screens/MusicPlayer/Musicplayer.dart';
import 'package:final2/Screens/Profile.dart';
import 'package:final2/Screens/Splash.dart';
import 'package:final2/Screens/Supplier.dart';
import 'package:final2/Screens/Upload/Upload.dart';
import 'package:final2/Screens/Upload/Upload_pdf.dart';
import 'package:final2/Screens/Upload/Upload_product.dart';
import 'package:final2/Screens/Welcome.dart';
import 'package:final2/Screens/onBoarding.dart';
import 'package:final2/auth/sign_up_page.dart';
import 'package:final2/auth/supplier_login.dart';
import 'package:final2/auth/supplier_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'Minor_screen/ForgetEmail.dart';
import 'Provider/FavouriteProvider.dart';
import 'Screens/CustomerHomeScreen.dart';
import 'Screens/OnBoarding1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'juctionScreen.dart';
import 'Screens/Profile1.dart';
import 'Screens/Upload/Test.dart';
import 'Screens/Upload/UploadPdf1.dart';

void main() async {

  // Stripe.publishableKey = stripePublishKey;
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // Stripe.urlScheme = 'flutterstripe';
  // await Stripe.instance.applySettings();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const MyApp()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Wish()),
      ],
      child: MaterialApp(
        title: 'Zen-Zone',
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        // home:  StreamBuilder(stream : FirebaseAuth.instance.authStateChanges()  , builder: (ctx ,snapshot) {
        //       if(snapshot.connectionState == ConnectionState.waiting){
        //         return CircularProgressIndicator();
        //       }
        //       else if(snapshot.hasData){
        //         return CustomerHomeScreen();
        //       }
        //       else{
        //          return SplashScreen();
        //       }
        // },),
        // home: Test(),
        initialRoute: "/Splash_screen",
        routes: {
          JunctionScreen.id : (context) => JunctionScreen(),
          '/Splash_screen': (context) => const SplashScreen(),
          '/OnBoarding_screen': (context) => onBoarding(),
          '/Welcome_screen': (context) => const WelcomeScreen(),
          '/Customer_screen': (context) => const CustomerHomeScreen(),
          '/Supplier_screen': (context) => const SupplierScreen(),
          ProfileScreen.id : (context) =>  ProfileScreen(documentId: FirebaseAuth.instance.currentUser!.uid),
          SignUpScreen.id : (context) => const SignUpScreen(),
          loginScreen.id : (context) => const loginScreen(),
          SupplierSignUpScreen.id : (context) => const SupplierSignUpScreen(),
          SupplierloginScreen.id : (context) => const SupplierloginScreen(),
        },
      ),
    );
  }
}
