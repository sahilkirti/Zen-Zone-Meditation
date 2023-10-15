import 'package:final2/Screens/Library.dart';
import 'package:final2/Screens/Profile.dart';
import 'package:final2/Screens/SupplierExplore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Explore.dart';
import 'Home.dart';
import 'Profile1.dart';
import 'Upload/Test.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  List<Widget> _tabs = [
    HomeScreen(documentId: FirebaseAuth.instance.currentUser!.uid,),
    SupplierExplore(),
    LibraryScreen(),
    // Profile1Screen(documentId: FirebaseAuth.instance.currentUser!.uid),
    Test(documentId: FirebaseAuth.instance.currentUser!.uid),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: GNav(
          haptic: false,
          curve: Curves.slowMiddle,
          backgroundColor:  Color(0xff41baf2),
          color: Colors.black,
          activeColor: Colors.white,
          rippleColor: Colors.black,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          tabBackgroundColor: Colors.grey.shade600,
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.explore, text: 'Explore'),
            GButton(icon: Icons.library_books_rounded, text: 'Library'),
            GButton(icon: Icons.account_circle_sharp, text: 'Profile'),
          ],
          gap: 8,
          onTabChange: (index)
          {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
