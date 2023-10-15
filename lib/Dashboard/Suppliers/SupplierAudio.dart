import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Minor_screen/Visitores/VisitorAudio.dart';

class SupplierAudioScreen extends StatefulWidget {
  const SupplierAudioScreen({Key? key}) : super(key: key);

  @override
  State<SupplierAudioScreen> createState() => _SupplierAudioScreenState();
}

class _SupplierAudioScreenState extends State<SupplierAudioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Supplier Audio",
          style: GoogleFonts.abyssinicaSil(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(6),
        child: StreamBuilder<QuerySnapshot>(
          stream:
          FirebaseFirestore.instance.collection('suppliers').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VisitorAudioScreen(
                                  suppId: snapshot.data!.docs[index]['sid'],
                                )));
                      },
                      child: Column(children: [
                        SizedBox(
                            height: 120,
                            width: 120,
                            child: Image.network(
                              snapshot.data!.docs[index]['profileimage'],
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            )),
                        Text(
                          snapshot.data!.docs[index]['name'].toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.abyssinicaSil(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ]),
                    );
                  });
            }
            return Container(
              child: Text('No store'),
            );
          },
        ),
      ),
    );
  }
}
