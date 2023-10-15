import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Modal/ProductModal/ProductModalBook1.dart';
import 'package:final2/Modal/ProductModal/ProductModelBook.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../Modal/ProductModal/ProductModal.dart';

class SelfHelpGallery extends StatefulWidget {
  const SelfHelpGallery({Key? key}) : super(key: key);

  @override
  State<SelfHelpGallery> createState() => _SelpHelpGalleryState();
}

class _SelpHelpGalleryState extends State<SelfHelpGallery> {
  final Stream<QuerySnapshot> _productStream =
  FirebaseFirestore.instance.collection('Book_detail').where('BookCategory',isEqualTo: 'Self Help').snapshots();

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
                'This category \n has no Self Help Book items yet !',
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
                return ProductModelBook1(products: snapshot.data!.docs[index],);
              },
              staggeredTileBuilder: (context) => const StaggeredTile.fit(1)),
        );
      },
    );
  }
}

