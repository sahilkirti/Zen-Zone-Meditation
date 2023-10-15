import 'package:final2/Dashboard/Balance.dart';
import 'package:final2/Dashboard/EditProfile.dart';
import 'package:final2/Dashboard/ManageProfile.dart';
import 'package:final2/Dashboard/Order.dart';
import 'package:final2/Dashboard/Statistic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Dashboard/StorePage.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> list = [
    'Store',
    'Order',
    'Edit Profile',
    'Manage Product',
    'Balance',
    'Statistic'
  ];

  List<IconData> icons = [
    Icons.store,
    Icons.shop_two_rounded,
    Icons.edit,
    Icons.settings,
    Icons.attach_money,
    Icons.add_chart,
  ];

  List<Widget> pages = [
    StorePageScreen(),
    OrderScreen(),
    EditProfileScreen(),
    ManageProfileScreen(),
    BalanceScreen(),
    StatisticScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Dashboard',
          style: GoogleFonts.abyssinicaSil(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        actions: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                icon : Icon(Icons.logout , size: 30, color: Colors.black,),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/Welcome_screen');
                },
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 50),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemCount: 6,
            itemBuilder: (BuildContext, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => pages[index]));
                },
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff8D8CF7),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(
                        icons[index],
                        color: Colors.black,
                        size: 80,
                      ),
                      Text(
                        list[index],
                        style: GoogleFonts.abyssinicaSil(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 25
                        ),
                      ),
                    ]),
                  ),
                ]),
              );
            }),
      ),
    );
  }
}
