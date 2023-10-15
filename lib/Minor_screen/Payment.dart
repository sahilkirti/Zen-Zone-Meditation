import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:uuid/uuid.dart';
import '../Provider/FavouriteProvider.dart';

class PaymentScreen extends StatefulWidget {
  final String titleName;
  final String image;
  final String Price;
  final dynamic products;

  const PaymentScreen(
      {Key? key,
      required this.titleName,
      required this.image,
      required this.Price,
      required this.products})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int SelectedValue = 1;
  late String orderId;
  CollectionReference customer =
      FirebaseFirestore.instance.collection('customer');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: customer.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
                child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Material(
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  centerTitle: true,
                  title: Text(
                    'Payment',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.abyssinicaSil(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
                backgroundColor: Colors.black,
                body: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .25,
                          width: MediaQuery.of(context).size.width * .98 + 2,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * .98 / 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(widget.image)),
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * .98 / 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Color(0xff9a79f5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total ',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.abyssinicaSil(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          widget.Price + ('₹'),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.abyssinicaSil(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .39,
                        width: MediaQuery.of(context).size.width * .98,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
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
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: SlideAction(
                          borderRadius: 5,
                          innerColor: Colors.black,
                          outerColor: Colors.white,
                          textStyle:
                              TextStyle(fontSize: 18, color: Colors.black),
                          onSubmit: () {
                            if (SelectedValue == 1) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1 /
                                                4.5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'Pay via Debit/Credit Card',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      GoogleFonts.abyssinicaSil(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                ),
                                                Text(
                                                  widget.Price + ('₹'),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      GoogleFonts.abyssinicaSil(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                print("Tap");
                                                for (var item in context
                                                    .read<Wish>()
                                                    .getWishItems) {
                                                  CollectionReference
                                                      ItemPayment =
                                                      FirebaseFirestore.instance
                                                          .collection('Orders');
                                                  orderId = const Uuid().v4();
                                                  await ItemPayment.doc(orderId)
                                                      .set({
                                                    'cid': data['cid'],
                                                    'custname': data['name'],
                                                    'email': data['email'],
                                                    'address': data['address'],
                                                    'phone': data['phone'],
                                                    'profileimage':
                                                        data['profileimage'],
                                                    'sid': item.documentId,
                                                    'orderid': orderId,
                                                    'ordername': item.name,
                                                    'orderimage':
                                                        item.imagesUrl.first,
                                                    'status': 'Confirmed',
                                                    'orderdate': DateTime.now(),
                                                    'paymentstatus':
                                                        'Via credit card',
                                                    'orderreview': false,
                                                  });
                                                }
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Center(
                                                  child: Text(
                                                    'Confirm ' +
                                                        ('₹') +
                                                        widget.Price,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                            } else if (SelectedValue == 2) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1 /
                                                4.5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'Pay via GooglePay/Phone Pe',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      GoogleFonts.abyssinicaSil(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                ),
                                                Text(
                                                  widget.Price + ('₹'),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      GoogleFonts.abyssinicaSil(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Center(
                                                  child: Text(
                                                    'Confirm ' +
                                                        ('₹') +
                                                        widget.Price,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                            }
                          },
                          text: "  Confirm to Pay " + ('₹') + widget.Price,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
