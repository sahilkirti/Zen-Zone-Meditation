import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Subscribed extends StatefulWidget {
  const Subscribed({Key? key}) : super(key: key);

  @override
  State<Subscribed> createState() => _SubscribedState();
}

class _SubscribedState extends State<Subscribed> {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('cid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went Wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(60, 100, 60, 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * .37,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/Blur/NoResult.jpg')),
                      border: Border.all(color: Colors.black, width: 2)),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      'No Subscribed Product',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.abyssinicaSil(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var order = snapshot.data!.docs[index];
              return Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color : Color(0xffadf9dd),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black, width: 1)),
                  child: ExpansionTile(
                      backgroundColor: Color(0xffadf9dd),
                      title: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: SingleChildScrollView(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                constraints:
                                BoxConstraints(maxHeight: 120, maxWidth: 120),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(order['orderImage'])),
                                    border:
                                    Border.all(color: Colors.black, width: 1)),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black, width: 2)),
                                      child: Center(
                                        child: Text(
                                          order['OrderName'],
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.abyssinicaSil(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 24,
                                              color: Colors.black),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width / 3,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black, width: 1)),
                                      child: Center(
                                        child: Text(
                                          (' ₹')+ order['orderPrice'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.abyssinicaSil(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 24,
                                              color: Colors.black),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width / 3,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                  ),
                ),
              );
            });
      },
    );
  }
}
