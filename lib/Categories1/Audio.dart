import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Modal/ProductModal/ProductModalAudio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../Modal/ProductModal/ProductModal.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final Stream<QuerySnapshot> _productStream =
  FirebaseFirestore.instance.collection('products').snapshots();

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
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(60, 100, 60, 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * .37,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
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
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      'No Audio Found',
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
                  return ProductModelAudio(products: snapshot.data!.docs[index],);
                },
                staggeredTileBuilder: (context) => const StaggeredTile.fit(1)),
          ),
        );
      },
    );
  }
}
