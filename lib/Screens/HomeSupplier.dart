import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Widgets/Carousal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupplierHomeScreen extends StatefulWidget {
  final String documentId;
  static const String id = '/Supplier_home_screen';
  const SupplierHomeScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  @override
  CollectionReference suppliers =
  FirebaseFirestore.instance.collection('suppliers');
  CollectionReference anonymous =
  FirebaseFirestore.instance.collection('anonymous');

  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: suppliers.doc(widget.documentId).get(),
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
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  'FeelBetter',
                  style: GoogleFonts.abyssinicaSil(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                backgroundColor: Colors.white,
                leading: Icon(
                  Icons.density_medium,
                  size: 30,
                  color: Colors.black,
                ),
                actions: [
                  InkWell(
                    //     onTap: (){
                    //       Navigator.pushReplacementNamed(context, ProfileScreen.id);
                    // },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black54,
                        backgroundImage: NetworkImage(data['profileimage']),
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  DestinationCarousal(),
                ],
              ),
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
