import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/PaymentScreens/Payment_2_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceOrder extends StatefulWidget {
  final String titleName;
  final String image;
  final String Price;
  final dynamic products;

  const PlaceOrder(
      {Key? key,
      required this.titleName,
      required this.image,
      required this.Price,
      this.products})
      : super(key: key);

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customer');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: customers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return SafeArea(child: const Text("Something went wrong"));
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return SafeArea(child: const Text("Document does not exist"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Material(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "Unlock the Beat",
                  style: GoogleFonts.abyssinicaSil(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: Colors.black),
                ),
                backgroundColor: Colors.white,
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    weight: 3,
                  ),
                ),
              ),
              body: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [BoxShadow(offset: Offset(2,2), spreadRadius: 0.2 , color: Colors.black)],
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .37,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(widget.image)),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 20,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                widget.titleName,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.abyssinicaSil(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                        height: MediaQuery.of(context).size.height / 11,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Name : ${data['name']}',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.abyssinicaSil(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 4,),
                              Text(
                                'Phone : ${data['phone']}',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.abyssinicaSil(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 4,),
                              Text(
                                'Email :  ${data['email']}',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.abyssinicaSil(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentViewScreen(
                                      titleName: widget.titleName,
                                      image: widget.image,
                                      Price: widget.Price,
                                      products: widget.products,
                                    )));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xffb2d5dd),
                            Color(0xffb7dfce),
                            Color(0xffafc2f9),
                          ]),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 1),
                          boxShadow: [BoxShadow(offset: Offset(3,3), spreadRadius: 0.2 , color: Colors.black)],
                        ),
                        child: Center(
                          child: Text(
                            "Unlock Zen-Zone with just " + ('₹') + widget.Price,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.abyssinicaSil(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  )
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
