import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ProductModelBook extends StatelessWidget {
  final dynamic products;

  const ProductModelBook({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => View(
                              products: products,
                              url: products['BookUrl'],
                            )));
              },
              child: Stack(children: [
                Container(
                  constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
                  child: Image(
                    image: NetworkImage(products['Bookimages'][0]),
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     // Text(
              //     //   products['Bookprice'].toStringAsFixed(2) + (' Rs'),
              //     //   maxLines: 2,
              //     //   overflow: TextOverflow.ellipsis,
              //     //   style: GoogleFonts.abyssinicaSil(
              //     //     color: Colors.black,
              //     //     fontWeight: FontWeight.w200,
              //     //   ),
              //     // ),
              //     products['sid'] == FirebaseAuth.instance.currentUser!.uid
              //         ? IconButton(
              //       onPressed: () {},
              //       icon: Icon(
              //         Icons.edit,
              //         color: Colors.black,
              //       ),
              //     )
              //         : Row(
              //       children: [
              //         IconButton(
              //           onPressed: () {
              //             // context.read<Favourite>().addItem(
              //             //     products['proname'], products['proimages'],
              //             //     products['proid'], products['sid']);
              //           },
              //           icon: Icon(
              //             Icons.favorite_border_outlined,
              //             color: Colors.red,
              //           ),
              //         ),
              //       ],
              //     )
              //   ],
              // )z
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
          onTap: (){
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
