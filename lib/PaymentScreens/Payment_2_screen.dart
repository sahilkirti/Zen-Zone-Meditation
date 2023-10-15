import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Screens/MusicPlayer/Musicplayer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:uuid/uuid.dart';

import '../Modal/ProductModal/ProductModalAudio.dart';

class PaymentViewScreen extends StatefulWidget {
  final String titleName;
  final String image;
  final String Price;
  final dynamic products;

  const PaymentViewScreen(
      {Key? key,
      required this.titleName,
      required this.image,
      required this.Price,
      this.products})
      : super(key: key);

  @override
  State<PaymentViewScreen> createState() => _PaymentViewScreenState();
}

class _PaymentViewScreenState extends State<PaymentViewScreen> {
  void showProgress() {
    ProgressDialog progress = ProgressDialog(context: context);
    progress.show(
        max: 100,
        msg: "Please Wait ...",
        msgColor: Colors.black,
        progressBgColor: Colors.black);
  }

  int SelectedValue = 1;
  late String orderId;
  late String SubscribeId;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customer');
  bool processing = false;

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
                  "Payment",
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
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(2, 2),
                                spreadRadius: 0.2,
                                color: Colors.black)
                          ],
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
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                            child: Container(
                                height: MediaQuery.of(context).size.height / 20,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
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
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Center(
                                        child: Text(
                                          'Total:' + (' ₹') + widget.Price,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.abyssinicaSil(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4.5,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 20,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RadioListTile(
                                activeColor: Colors.black,
                                value: 1,
                                groupValue: SelectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    SelectedValue = value!;
                                  });
                                },
                                title: Text(
                                  'Pay via Debit/Credit Card',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.abyssinicaSil(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      Icons.payment,
                                      color: Colors.black,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.ccMastercard,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.ccVisa,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              RadioListTile(
                                activeColor: Colors.black,
                                value: 2,
                                groupValue: SelectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    SelectedValue = value!;
                                  });
                                },
                                title: Text(
                                  'Pay via GooglePay/PhonePe',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.abyssinicaSil(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.googlePay,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: InkWell(
                        onTap: () {
                          if (SelectedValue == 1) {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Pay via Debit/Credit Card',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.abyssinicaSil(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              ('₹') + widget.Price,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.abyssinicaSil(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            processing = true;
                                          });
                                          CollectionReference orderRef =
                                              FirebaseFirestore.instance
                                                  .collection('orders');
                                          orderId = Uuid().v4();
                                          try {
                                            await orderRef.doc(orderId).set({
                                              //customer Information
                                              'cid': data['sid'],
                                              'custname': data['name'],
                                              'email': data['email'],
                                              'address': data['address'],
                                              'phone': data['phone'],
                                              'profile': data['profileimage'],
                                              //supplier Information
                                              'sid': widget.products['sid'],
                                              //product Information
                                              "orderId": orderId,
                                              'orderImage': widget
                                                  .products['proimages'][0],
                                              'orderPrice':
                                                  widget.products['price'],
                                              'delivery':
                                                  "Pay via Debit/Credit Card",
                                              'date': DateTime.now(),
                                              'OrderReview': false,
                                              'proid': widget.products['proid'],
                                              'OrderName':
                                                  widget.products['proname'],
                                              'orderStatus': true
                                            }).whenComplete(() {
                                              setState(() {
                                                processing = false;
                                                Future.delayed(Duration(seconds: 2));
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MusicPlayer(
                                                              titleName: widget
                                                                      .products[
                                                                  'proname'],
                                                              image: widget
                                                                      .products[
                                                                  'proimages'][0],
                                                              AuthorName:
                                                                  'riddhish',
                                                              product: widget
                                                                  .products,
                                                              price: widget
                                                                  .products[
                                                                      'price']
                                                                  .toStringAsFixed(
                                                                      2),
                                                            )));
                                              });
                                            });
                                          } catch (e) {
                                            print(e);
                                          }
                                          ;
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              20,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color(0xffb2d5dd),
                                              Color(0xffb7dfce),
                                              Color(0xffafc2f9),
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.black, width: 2),
                                          ),
                                          child: processing == true
                                              ? CircularProgressIndicator(
                                                  color: Colors.black,
                                                )
                                              : Center(
                                                  child: Text(
                                                    "To Pay  " +
                                                        ('₹') +
                                                        widget.Price,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts
                                                        .abyssinicaSil(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 24,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (SelectedValue == 2) {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Pay via GooglePay/PhonePe',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.abyssinicaSil(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              ('₹') + widget.Price,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.abyssinicaSil(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            processing = true;
                                          });
                                          CollectionReference orderRef =
                                              FirebaseFirestore.instance
                                                  .collection('orders');
                                          orderId = Uuid().v4();

                                          try {
                                            await orderRef.doc(orderId).set({
                                              //customer Information
                                              'cid': data['sid'],
                                              'custname': data['name'],
                                              'email': data['email'],
                                              'address': data['address'],
                                              'phone': data['phone'],
                                              'profile': data['profileimage'],
                                              //supplier Information
                                              'sid': widget.products['sid'],
                                              //product Information
                                              "orderId": orderId,
                                              'orderImage': widget
                                                  .products['proimages'][0],
                                              'orderPrice':
                                                  widget.products['price'],
                                              'delivery':
                                                  "Pay via GooglePay/PhonePe Card",
                                              'date': DateTime.now(),
                                              'OrderReview': false,
                                              'proid': widget.products['proid'],
                                              'OrderName':
                                                  widget.products['proname'],
                                              'orderStatus': true
                                            }).whenComplete(() {
                                              setState(() {
                                                processing = false;
                                                MusicPlayer(
                                                  titleName: widget
                                                      .products['proname'],
                                                  image: widget
                                                      .products['proimages'][0],
                                                  AuthorName: 'riddhish',
                                                  product: widget.products,
                                                  price: widget
                                                      .products['price']
                                                      .toStringAsFixed(2),
                                                );
                                              });
                                            });
                                          } catch (e) {
                                            print(e);
                                          }
                                          ;
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              20,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color(0xffb2d5dd),
                                              Color(0xffb7dfce),
                                              Color(0xffafc2f9),
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.black, width: 2),
                                          ),
                                          child: processing == true
                                              ? CircularProgressIndicator(
                                                  color: Colors.black,
                                                )
                                              : Center(
                                                  child: Text(
                                                    "To Pay  " +
                                                        ('₹') +
                                                        widget.Price,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts
                                                        .abyssinicaSil(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 24,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
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
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              "Confirm Payment " + ('₹') + widget.Price,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.abyssinicaSil(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
