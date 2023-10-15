import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Modal/ProductModal/ProductModalBook1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class VisitorPdfScreen extends StatefulWidget {
  final String suppId;
  const VisitorPdfScreen({Key? key, required this.suppId}) : super(key: key);

  @override
  State<VisitorPdfScreen> createState() => _VisitorPdfScreenState();
}

class _VisitorPdfScreenState extends State<VisitorPdfScreen> {
  bool following = false;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('Book_detail')
        .where('sid', isEqualTo: widget.suppId)
        .snapshots();
    CollectionReference user =
        FirebaseFirestore.instance.collection('suppliers');
    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(widget.suppId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text('Something went wrong');
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
              toolbarHeight: 100,
              flexibleSpace: Container(
                color: Colors.black,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 2, color: Colors.white),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        data['profileimage'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        data['name'].toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      data['sid'] == FirebaseAuth.instance.currentUser!.uid
                          ? Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width * .30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.pink),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [Text('Edit'), Icon(Icons.edit)],
                                  )),
                            )
                          : Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width * .30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.pink),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    following = !following;
                                  });
                                },
                                child: following == true
                                    ? Text('Following')
                                    : Text('Follow'),
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: _productStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Material(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Text(
                    'This has no Products!',
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
                        return ProductModelBook1(
                          products: snapshot.data!.docs[index],
                        );
                      },
                      staggeredTileBuilder: (context) =>
                          const StaggeredTile.fit(1)),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.green,
              child: Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
                size: 40,
              ),
            ),
          );
        }

        return Text('loading');
      },
    );
  }
}
