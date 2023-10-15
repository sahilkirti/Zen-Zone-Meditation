import 'package:final2/auth/LoginScreen.dart';
import 'package:final2/auth/sign_up_page.dart';
import 'package:final2/auth/supplier_login.dart';
import 'package:final2/auth/supplier_signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffeafddd), Color(0xffcff6e7) , Color(0xff41baf2)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 100,
              ),
              Lottie.network(
                  'https://assets2.lottiefiles.com/packages/lf20_pprxh53t.json',
                  height: size.height * 0.35),
              SizedBox(
                height: 70,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Find your Zen\n Find your Balance with Zen Zone',
                  style: GoogleFonts.abyssinicaSil(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // paddingDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Customer',
                            style: GoogleFonts.abyssinicaSil(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          ExtractedColumn1(),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Admin Panel',
                            style: GoogleFonts.abyssinicaSil(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          ExtractedColumn(),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  // paddingDivider(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class paddingDivider extends StatelessWidget {
  const paddingDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Divider(
        color: Colors.black,
        thickness: 2,
      ),
    );
  }
}

class ExtractedColumn extends StatelessWidget {
  const ExtractedColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 60),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(
                    width: 2, color: Colors.black, style: BorderStyle.solid),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, SupplierloginScreen.id);
            },
            child: Text(
              'Login',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            )),
        ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 52),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xff141515),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(
                    width: 2, color: Colors.black, style: BorderStyle.solid),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, SupplierSignUpScreen.id);
            },
            child: Text(
              'Sign up',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ))
      ],
    );
  }
}

class ExtractedColumn1 extends StatelessWidget {
  const ExtractedColumn1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 60),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(
                    width: 2, color: Colors.black, style: BorderStyle.solid),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, loginScreen.id);
            },
            child: Text(
              'Login',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            )),
        ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 52),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xff141515),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(
                    width: 2, color: Colors.black, style: BorderStyle.solid),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, SignUpScreen.id);
            },
            child: Text(
              'Sign up',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ))
      ],
    );
  }
}
