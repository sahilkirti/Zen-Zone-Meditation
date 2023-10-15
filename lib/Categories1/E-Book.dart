import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../Minor_screen/SubCategoryScreen.dart';
import '../Modal/ProductModal/ProductModal.dart';
import '../Modal/ProductModal/ProductModelBook.dart';

class EbookScreen extends StatefulWidget {
  const EbookScreen({Key? key}) : super(key: key);

  @override
  State<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {
  var colorArray = [
    Color(0xfffeeac0),
    Color(0xff7147e8),
    Color(0xffcafef6),
    Color(0xffb3a0cf),
    Color(0xfff3c664),
    Color(0xfffebde5),
    Colors.amber,
    Colors.deepOrangeAccent,
    Colors.grey,
    Colors.black12,
    Colors.blueAccent,
    Colors.deepPurpleAccent,
    Colors.yellowAccent,
    Colors.blueGrey,
    Colors.pink,
    Colors.red,
    Colors.orange,
    Colors.green,
  ];

  var Track = [
    'Pdf1',
    'Pdf2',
    'Pdf3',
    'Pdf4',
    'Pdf5',
    'Pdf6',
    'Pdf7',
    'Pdf8',
    'Pdf9',
    'Pdf10',
    'Pdf11',
    'Pdf12',
    'Pdf13',
    'Pdf14',
    'Pdf15',
    'Pdf16',
    'Pdf17',
    'Pdf18',
  ];

  final Stream<QuerySnapshot> _productStream =
  FirebaseFirestore.instance.collection('Book_detail').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return  Center(
              child: Text(
                'No Ebooks',
                textAlign: TextAlign.center,
                style: GoogleFonts.abyssinicaSil(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ));
        }

        return SingleChildScrollView(
          child: StaggeredGridView.countBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              crossAxisCount: 2,
              itemBuilder: (context, index) {
                return ProductModelBook(products: snapshot.data!.docs[index],);
              },
              staggeredTileBuilder: (context) => const StaggeredTile.fit(1)),
        );
      },
    );
  }
}