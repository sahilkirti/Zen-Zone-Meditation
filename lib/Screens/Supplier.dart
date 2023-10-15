import 'package:final2/Dashboard/StorePage.dart';
import 'package:final2/Screens/Dashboard.dart';
import 'package:final2/Screens/HomeSupplier.dart';
import 'package:final2/Screens/SupplierExplore.dart';
import 'package:final2/Screens/Upload/Upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  List<Widget> _tabs = [
    SupplierHomeScreen(documentId: FirebaseAuth.instance.currentUser!.uid),
    SupplierExplore(),
    StorePageScreen(),
    DashboardScreen(),
    Upload(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: GNav(
            curve: Curves.easeInToLinear,
            backgroundColor: Colors.white,
            color: Colors.black,
            activeColor: Colors.white,
            rippleColor: Colors.black,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            tabBackgroundColor: Colors.grey.shade600,
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.explore, text: 'Explore'),
              GButton(icon: Icons.store , text: 'Store',),
              GButton(icon: Icons.dashboard, text: 'Dashboard'),
              GButton(icon: Icons.upload, text: 'Upload'),
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
      ),
    );
  }
}


