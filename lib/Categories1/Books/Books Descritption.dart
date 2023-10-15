import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Modal/ProductModal/BookCategoryModel/ProductModalBook1HomeView.dart';
import 'package:final2/PaymentScreens/Payment_Screen_pdf.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Books.dart';

class BookDecription extends StatefulWidget {
  final dynamic products;

  BookDecription(
  {required this.products,
    }

  );

  @override
  State<BookDecription> createState() => _BookDecriptionState();
}

class _BookDecriptionState extends State<BookDecription> {
  var bookopened;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: "Ubuntu"),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(5)),
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.80,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  physics: BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast),
                  child: Text(
                    widget.products['Bookdesc'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.3,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .004,
              ),
              Container(
                padding: EdgeInsets.all(13),
                height: MediaQuery.of(context).size.height * 0.2,
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black, width: 1.5),
                  color: Colors.white,
                ),
                child: LayoutBuilder(
                  builder: (ctx, constraints) {
                    return Column(
                      children: [
                        SizedBox(height: 18),
                        Container(
                          height: constraints.maxHeight * 0.450,
                          child: ListTile(
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  widget.products['Bookimages'][0],
                                  fit: BoxFit.cover,
                                )),
                            title: Text(
                              widget.products['Bookname'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              "By " + widget.products['BookAuthor'],
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Container(
                              padding: EdgeInsets.all(5),
                              // color: Colors.redAccent.shade100,
                              child: Text(
                                "₹ ${widget.products['Bookprice']}/-",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.05,
                        ),
                        GestureDetector(
                          child: Container(
                            height: constraints.maxHeight * 0.3,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                gradient: LinearGradient(colors: [
                                  Color(0xffb2d5dd),
                                  Color(0xffb7dfce),
                                  Color(0xffafc2f9),
                                ]),
                                borderRadius: BorderRadius.circular(5)),

                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('orders')
                                    .where('cid',
                                    isEqualTo: FirebaseAuth
                                        .instance.currentUser!.uid)
                                    .where('proid',
                                    isEqualTo:
                                    widget.products['Bookid'])
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    );
                                  } else if (snapshot
                                      .data!.docs.isEmpty || !snapshot.hasData) {
                                    return Text(
                                          "Buy Now",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Ubuntu",
                                              fontSize: 16));
                                  } else {
                                    return Text(
                                        "Open Now",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Ubuntu",
                                            fontSize: 16));
                                  }
                                })
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('orders')
                                            .where('cid',
                                                isEqualTo: FirebaseAuth
                                                    .instance.currentUser!.uid)
                                            .where('proid',
                                                isEqualTo:
                                                    widget.products['Bookid'])
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.black,
                                              ),
                                            );
                                          } else if (snapshot
                                              .data!.docs.isEmpty || !snapshot.hasData) {
                                            return PaymentViewScreenPdf(
                                              titleName:
                                                  widget.products['Bookname'],
                                              image: widget
                                                  .products['Bookimages'][0],
                                              Price: widget
                                                  .products['Bookprice']
                                                  .toString(),
                                              products: widget.products,
                                            );
                                          } else {
                                            // bookopened = [widget.products['Bookname'] , widget
                                            //     .products['Bookimages'][0] , widget.products['BookUrl']];

                                            return View(
                                              products: widget.products,
                                                url: widget.products['BookUrl']);
                                          }
                                        })));
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => PaymentViewScreenPdf(
                            //             titleName: widget.products['Bookname'],
                            //             image: widget.products['Bookimages'][0],
                            //             Price: widget.products['Bookprice'].toString(),
                            //             products: widget.products,
                            //         )));
                          },
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
