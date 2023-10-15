import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Screens/MusicPlayer/Musicplayer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../../PaymentScreens/Payment_1_screen.dart';

class ProductModelAudio extends StatelessWidget {
  final dynamic products;
  dynamic orderId;

  ProductModelAudio({super.key, required this.products, this.orderId});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('orders')
                        .where('cid', isEqualTo: user!.uid)
                        .where('proid', isEqualTo: products['proid'])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return PlaceOrder(
                          products: products,
                          titleName: products['proname'],
                          image: products['proimages'][0],
                          Price: products['price'].toStringAsFixed(2),
                        );
                      } else {
                        return MusicPlayer(
                          titleName: products['proname'],
                          image: products['proimages'][0],
                          AuthorName: 'riddhish',
                          product: products,
                          price: products['price'].toStringAsFixed(2),
                        );
                      }
                    })));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => PlaceOrder(
        //             products: products,
        //             titleName: products['proname'],
        //             image: products['proimages'][0],
        //             Price: products['price'].toStringAsFixed(2))));
      },

      //--------------------------------------------
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(2, 2),
                    spreadRadius: 0.3,
                    color: Colors.black)
              ],
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.white,
              borderRadius: BorderRadius.circular(7)),
          child: SingleChildScrollView(
            child: Column(children: [
              Stack(children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      constraints:
                          BoxConstraints(minHeight: 100, maxHeight: 200),
                      child: Image(
                        image: NetworkImage(products['proimages'][0]),
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('orders')
                        .where('cid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .where('proid', isEqualTo: products['proid'])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox();
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    }),
              ]),
              Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 28,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        products['proname'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.abyssinicaSil(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
