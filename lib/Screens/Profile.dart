import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Minor_screen/ChangePassword.dart';
import 'package:final2/ProfileList/Favourites.dart';
import 'package:final2/ProfileList/coursedetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Provider/FavouriteProvider.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;
  static const String id = '/Profile_screen';
  const ProfileScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customer');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');

  final DateTime today = DateTime.now();

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
            return Scaffold(
              backgroundColor: Colors.grey.shade300,
              body: Stack(
                children: [
                  Container(
                    height: 236,
                    decoration: BoxDecoration(
                      color: Color(0xfff3d171),
                    ),
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        centerTitle: true,
                        pinned: true,
                        elevation: 0,
                        backgroundColor: Colors.black,
                        expandedHeight: 140,
                        flexibleSpace: LayoutBuilder(
                          builder: (context, constraints) {
                            return FlexibleSpaceBar(
                              title: AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity:
                                    constraints.biggest.height <= 120 ? 1 : 0,
                                child: const Text(
                                  'Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xfff3d171),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 25, left: 30),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height*0.09,
                                        width:  MediaQuery.of(context).size.height*0.1 ,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black, width: 1.5),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(data['profileimage'])
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height*.03,
                                          width: MediaQuery.of(context).size.width*.4,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Center(
                                            child: Text(
                                              data['name'].toUpperCase(),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                              softWrap: false,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Badge(
                                  label: Text(context.watch<Wish>().getWishItems.length.toString()),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(color: Colors.white , width: 4),
                                        borderRadius: BorderRadius.circular(50)),
                                    child: TextButton(
                                      child: SizedBox(
                                        height: 40,
                                        width: MediaQuery.of(context).size.width *
                                            0.23,
                                        child: Center(
                                          child: Text(
                                            'Favorites',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FavouritesScreen()));
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(color: Colors.white , width: 4),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: TextButton(
                                    child: SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.23,
                                      child: Center(
                                        child: Text(
                                          'Courses',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomerCourses()));
                                    },
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(color: Colors.white , width: 4),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: TextButton(
                                    child: SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.23,
                                      child: Center(
                                        child: Text(
                                          'Statistic',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                            Container(
                              color: Colors.grey.shade300,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black , width: 2),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TableCalendar(
                                        locale: 'en_us',
                                        headerStyle: HeaderStyle(
                                            formatButtonVisible: false,
                                            titleCentered: true),
                                        focusedDay: today,
                                        firstDay: DateTime.utc(2010, 10, 16),
                                        lastDay: DateTime.utc(2030, 10, 16)),
                                    margin: EdgeInsets.all(10),
                                  ),
                                  const ProfileHeaderLabel(
                                    headerLabel: '  Account Info.  ',
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 260,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          RepeatedListTile(
                                              icon: Icons.email,
                                              subTitle: data['email'],
                                              title: 'Email Address'),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                              icon: Icons.phone,
                                              subTitle: data['phone'],
                                              title: 'Phone No.'),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                              icon: Icons.location_pin,
                                              subTitle: data['address'],
                                              title: 'Address'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const ProfileHeaderLabel(
                                      headerLabel: '  Account Settings  '),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 260,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          RepeatedListTile(
                                            title: 'Edit Profile',
                                            subTitle: '',
                                            icon: Icons.edit,
                                            onPressed: () {},
                                          ),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                            title: 'Change Password',
                                            icon: Icons.lock,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChangePasswordScreen()));
                                            },
                                          ),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                            title: 'Log Out',
                                            icon: Icons.logout,
                                            onPressed: () async {
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
  }
}

class AppbarBackButton {}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        color: Colors.black,
        thickness: 2,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;

  const RepeatedListTile(
      {Key? key,
      required this.icon,
      this.onPressed,
      this.subTitle = '',
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;

  const ProfileHeaderLabel({Key? key, required this.headerLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
          Text(
            headerLabel,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 30,
            width: 40,
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
