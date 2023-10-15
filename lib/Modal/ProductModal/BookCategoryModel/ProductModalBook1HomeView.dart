import 'package:final2/Categories1/Books/Books%20Descritption.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ProductModelBook1HomeView extends StatelessWidget {
  final dynamic products;

  const ProductModelBook1HomeView({
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
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black , width: 3),
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
            )),
            BookDecription(products: products,)

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: GestureDetector(
              onTap: () {
                bookDes(context, products);
              },
              child: Stack(children: [
                Container(
                  constraints: BoxConstraints(minHeight: 90, maxHeight: 160),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 20,
                          spreadRadius: 20),
                    ],
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(products['Bookimages'][0]),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(children: [
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
              // Align(
              //   child: Text(
              //     'Author: ' + products['BookAuthor'],
              //     maxLines: 2,
              //     overflow: TextOverflow.ellipsis,
              //     style: GoogleFonts.abyssinicaSil(
              //       color: Colors.black,
              //       fontSize: 13,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              //   alignment: Alignment.topLeft,
              // ),
            ]),
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
