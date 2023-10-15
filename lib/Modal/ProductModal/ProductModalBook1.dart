// import 'package:final2/Provider/ProductProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Categories1/Books/Books%20Descritption.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ProductModelBook1 extends StatelessWidget {
  final dynamic products;

  const ProductModelBook1({
    super.key,
    required this.products,
  });

  void bookDes(BuildContext ctx, dynamic product) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: ctx,
      builder: (context) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20))),
            ),
            BookDecription(products: product)
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(offset: Offset(3,3), spreadRadius: 0.3 , color: Colors.black)],
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: GestureDetector(
              onTap: () {
                bookDes(context, products);
              },
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                  ),
                  constraints: BoxConstraints(minHeight: 90, maxHeight: 200),
                  child: Image(
                    image: NetworkImage(products['Bookimages'][0]),
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('orders')
                        .where('cid',
                        isEqualTo: FirebaseAuth
                            .instance.currentUser!.uid)
                        .where('proid',
                        isEqualTo:
                        products['Bookid'])
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
                        return Padding(
                          padding: EdgeInsets.all(5),
                            child: Icon(Icons.lock , color: Colors.black,));
                      } else {
                        return SizedBox();
                      }
                    })
              ]),
            ),
          ),
         // width: MediaQuery.of(context).size.width/2.2,
         // padding: EdgeInsets.only(left: 2, top: 10, bottom: 2, right: 2),
          Padding(
            padding: EdgeInsets.only(left: 2, top: 10, bottom: 2, right: 2),
            child: Container(
              width: MediaQuery.of(context).size.width/2.0 ,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: Colors.black, width: 1)),
              child: Column(
                  children: [
                Align(
                  child: Text(
                    products['Bookname'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.abyssinicaSil(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
                Align(
                  child: Text(
                    'Author: ' + products['BookAuthor'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.abyssinicaSil(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class View extends StatelessWidget {
  PdfViewerController? _pdfViewerController;
  final url;
  final dynamic products;

  View({Key? key, required this.url, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          products['Bookname'],
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
      ),
    );
  }
}
