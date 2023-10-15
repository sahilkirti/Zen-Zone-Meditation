import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          double totalPrice = 0.0;
          for(var item in snapshot.data!.docs)
            {
              totalPrice += item['orderPrice']*snapshot.data!.docs.length;
            }

          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                'Statistic',
                style: GoogleFonts.abyssinicaSil(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WidgetContainer(label: "Item Sold : ", value: snapshot.data!.docs.length.toString()),
                  WidgetContainer(label: "Total Balance : Rs ", value: totalPrice),
                ],
              ),
            ),
          );
        });
  }
}

class WidgetContainer extends StatelessWidget {
  final String label;
  final dynamic value;

  const WidgetContainer({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.abyssinicaSil(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value.toString(),
                style: GoogleFonts.abyssinicaSil(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
