import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../Modal/ProductModal/ProductModal.dart';

class ProductivityGallery extends StatefulWidget {
  const ProductivityGallery({Key? key}) : super(key: key);

  @override
  State<ProductivityGallery> createState() => _ProductivityGalleryState();
}

class _ProductivityGalleryState extends State<ProductivityGallery> {
  final Stream<QuerySnapshot> _productStream =
  FirebaseFirestore.instance.collection('products').where('maincateg',isEqualTo: 'Productivity').snapshots();

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
          return  Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffeafddd), Color(0xffcff6e7) , Color(0xff41baf2)],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 100, 60, 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .37,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [BoxShadow(offset: Offset(1,1), spreadRadius: 0.3 , color: Colors.black)],
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
                      boxShadow: [BoxShadow(offset: Offset(1,1), spreadRadius: 0.3 , color: Colors.black)],
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        'This category \n has no Productivity items yet !',
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
            ),
          );
        }

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffeafddd), Color(0xffcff6e7) , Color(0xff41baf2)],
            ),
          ),
          child: SingleChildScrollView(
            child: StaggeredGridView.countBuilder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                crossAxisCount: 2,
                itemBuilder: (context, index) {
                  return ProductModel(products: snapshot.data!.docs[index],);
                },
                staggeredTileBuilder: (context) => const StaggeredTile.fit(1)),
          ),
        );
      },
    );
  }
}

