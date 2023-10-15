import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile1Screen extends StatefulWidget {
  const Profile1Screen({Key? key, required this.documentId}) : super(key: key);
  final String documentId;
  static const String id = '/Profile_screen';

  @override
  State<Profile1Screen> createState() => _Profile1ScreenState();
}

class _Profile1ScreenState extends State<Profile1Screen> {
  CollectionReference customers =
  FirebaseFirestore.instance.collection('customer');
  CollectionReference anonymous =
  FirebaseFirestore.instance.collection('anonymous');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: customers.doc(widget.documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return SafeArea(child: const Text("Something went wrong"));
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return SafeArea(child: const Text("Document does not exist"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Favourites',
                  style: GoogleFonts.abyssinicaSil(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black),
                ),
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.white,
              ),
              body: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  height: MediaQuery.of(context).size.width*.3,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black , width: 2)
                  ),
                )
              ]),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
  }
}

Widget BuildImages() =>
    SliverToBoxAdapter(
      child: Container(
        decoration:
        BoxDecoration(border: Border.all(color: Colors.black)),
      ),
    );