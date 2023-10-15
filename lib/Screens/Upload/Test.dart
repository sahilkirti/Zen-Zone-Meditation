import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Minor_screen/ChangePassword.dart';
import 'package:final2/Minor_screen/StreakCalculation.dart';
import 'package:final2/ProfileList/Favourites.dart';
import 'package:final2/ProfileList/coursedetail.dart';
import 'package:final2/Setting/Setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class Test extends StatefulWidget {
  const Test({Key? key, required this.documentId}) : super(key: key);
  final String documentId;

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customer');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: customers.doc(widget.documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return SafeArea(child: const Text("Something went wrong"));
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return SafeArea(child: const Text("Document does not exist"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffeafddd), Color(0xffcff6e7) , Color(0xff41baf2)],
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(
                    'Profile',
                    style: GoogleFonts.abyssinicaSil(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black),
                  ),
                  elevation: 0,
                  centerTitle: true,
                  backgroundColor: Color(0xfff0f8f6),
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  physics:ClampingScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(

                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .9,
                              height: MediaQuery.of(context).size.width * .3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(3, 3),
                                      spreadRadius: 0.3,
                                      color: Color(0xffcceac8))
                                ],
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: 10, right:0, bottom: 0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height * 0.2,
                                      width:
                                          MediaQuery.of(context).size.width * 0.2,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(data['profileimage'])
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10, top: 10),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height *
                                          0.38,
                                      width: MediaQuery.of(context).size.width *
                                          0.61,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),

                                      ),
                                      child: Center(
                                        child: Text(
                                          'Hi,\n${data['name'].toUpperCase()}',
                                          style: GoogleFonts.abyssinicaSil(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 24,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 0, top: 10),
                            child: Text(
                              'Special Promotion',
                              style: GoogleFonts.abyssinicaSil(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .9,
                              height: MediaQuery.of(context).size.height * .30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(2, 2),
                                      spreadRadius: 0.3,
                                      color: Colors.black)
                                ],
                              ),
                              child: OverflowBox(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.width * .43,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                              filterQuality: FilterQuality.high,
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'images/Blur/blur1.jpg')),
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 0, top: 1),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                'World Meditation day',
                                                style: GoogleFonts.abyssinicaSil(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              height:
                                              MediaQuery.of(context).size.height * .05,
                                              child: Text(
                                                'Make Your Meditation Skill Grow Fast 20% off on each Card',
                                                style: GoogleFonts.abyssinicaSil(
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 14,
                                                    color: Colors.grey.shade700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 0, bottom: 10, top: 10),
                            child: Column(
                              children: [
                                NewWidget(
                                  title: "Name",
                                  content: data['name'],
                                ),
                                NewWidget(
                                  title: "Email",
                                  content: data['email'],
                                ),
                                NewWidget(title: 'Phone', content: "+91 "+"${data['phone']}")
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 0, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subscribed',
                                  style: GoogleFonts.abyssinicaSil(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23,
                                      color: Colors.black),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerCourses()));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * .2,
                                    height:
                                        MediaQuery.of(context).size.height * .038,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black, width: 1)),
                                    child: Center(
                                      child: Text(
                                        'View All',
                                        style: GoogleFonts.abyssinicaSil(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 0, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Favourites',
                                  style: GoogleFonts.abyssinicaSil(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: Colors.black),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FavouritesScreen()));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * .2,
                                    height:
                                    MediaQuery.of(context).size.height * .038,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black, width: 1)),
                                    child: Center(
                                      child: Text(
                                        'View All',
                                        style: GoogleFonts.abyssinicaSil(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 0, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Check Stat',
                                  style: GoogleFonts.abyssinicaSil(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: Colors.black),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MeditationStreak()));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * .2,
                                    height:
                                    MediaQuery.of(context).size.height * .038,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black, width: 1)),
                                    child: Center(
                                      child: Text(
                                        'View All',
                                        style: GoogleFonts.abyssinicaSil(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 11, bottom: 0, top: 15),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (contex) => ChangePasswordScreen()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * .9,
                                height: MediaQuery.of(context).size.height * .0659,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  gradient: LinearGradient(colors: [
                                    Color(0xffaec2fa),
                                    Color(0xffb6e6c5),
                                  ]),
                                  border: Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 10 , right: 10),
                                        child: Icon(Icons.change_circle_outlined, color: Colors.black, size: 20,)),
                                    VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Text(
                                      'Change Password',
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.abyssinicaSil(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 11, bottom: 0, top: 5),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (contex) => SettingScreen()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * .9,
                                height: MediaQuery.of(context).size.height * .0659,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  gradient: LinearGradient(colors: [
                                    Color(0xffaec2fa),
                                    Color(0xffb6e6c5),
                                  ]),
                                  border: Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 10 , right: 10),
                                        child: Icon(Icons.change_circle_outlined, color: Colors.black, size: 20,)),
                                    VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Text(
                                      'Settings',
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.abyssinicaSil(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 11, bottom: 0, top: 5),
                            child: GestureDetector(
                              onTap: (){
                                Share.share('com.example.final2');
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * .9,
                                height: MediaQuery.of(context).size.height * .0659,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  gradient: LinearGradient(colors: [
                                    Color(0xffaec2fa),
                                    Color(0xffb6e6c5),
                                  ]),
                                  border: Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 10 , right: 10),
                                        child: Icon(Icons.share_outlined, color: Colors.black, size: 20,)),
                                    VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Text(
                                      'Share With Friends',
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.abyssinicaSil(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                      padding: EdgeInsets.only(left: 10, right: 11, bottom: 0, top: 5),
                      child: GestureDetector(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder:
                                  (BuildContext context) =>
                                  CupertinoAlertDialog(
                                    title: new Text(
                                        "Logging Out"),
                                    content: new Text(
                                        "Are you sure you want to log out?"),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                          isDefaultAction:
                                          true,
                                          child: Text(
                                              'Yes'),
                                          onPressed:
                                              () async {
                                            await FirebaseAuth
                                                .instance
                                                .signOut();
                                            Navigator.pop(
                                                context);
                                            Navigator.pushReplacementNamed(
                                                context,
                                                '/Welcome_screen');
                                          }),
                                      CupertinoDialogAction(
                                        child:
                                        Text('No'),
                                        onPressed: () {
                                          Navigator.pop(
                                              context);
                                        },
                                      )
                                    ],
                                  ));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .9,
                          height: MediaQuery.of(context).size.height * .0659,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(colors: [
                              Color(0xffaec2fa),
                              Color(0xffb6e6c5),
                            ]),
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10 , right: 10),
                                  child: Icon(Icons.logout, color: Colors.black, size: 17,)),
                              VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Text(
                                'Log Out',
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.abyssinicaSil(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 11, bottom: 0, top: 5),
                            child: GestureDetector(
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => CupertinoAlertDialog(
                                      title: new Text("Exit"),
                                      content: new Text("Are you sure you want to Exit out?"),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                            isDefaultAction: true,
                                            child: Text('Yes'),
                                            onPressed: () {
                                              SystemNavigator.pop();
                                            }),
                                        CupertinoDialogAction(
                                          child: Text('No'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * .9,
                                height: MediaQuery.of(context).size.height * .0659,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  gradient: LinearGradient(colors: [
                                    Color(0xffaec2fa),
                                    Color(0xffb6e6c5),
                                  ]),
                                  border: Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 10 , right: 10),
                                        child: Icon(Icons.transit_enterexit_sharp, color: Colors.black, size: 20,)),
                                    VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Text(
                                      'Exit App',
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.abyssinicaSil(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ]),
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
  }
}

class NewWidget extends StatelessWidget {
  final String title;
  final String content;

  NewWidget({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        height: MediaQuery.of(context).size.height * .0659,
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(colors: [
            Color(0xffaec2fa),
            Color(0xffb6e6c5),
          ]),
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                title,
                overflow: TextOverflow.fade,
                style: GoogleFonts.abyssinicaSil(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black),
              ),
            ),
            VerticalDivider(
              color: Colors.black,
              thickness: 1,
            ),
            Text(
              content,
              overflow: TextOverflow.fade,
              style: GoogleFonts.abyssinicaSil(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
