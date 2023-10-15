
import 'package:final2/Dashboard/Suppliers/SupplierVideo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Suppliers/SupplierAudio.dart';
import 'Suppliers/SupplierPdf.dart';

class StorePageScreen extends StatefulWidget {
  const StorePageScreen({Key? key}) : super(key: key);

  @override
  State<StorePageScreen> createState() => _StorePageScreenState();
}

class _StorePageScreenState extends State<StorePageScreen> {
  List<String> list = [
    'Supplier Audio',
    'Supplier Books',
    'Supplier Video',
  ];

  List<IconData> icons = [
    Icons.audio_file,
    Icons.book,
    Icons.video_library,
  ];

  List<Color> colorarray= [
    Colors.deepOrange,
    Colors.blueAccent,
    Colors.green
  ];
  List<Widget> pages = [
    SupplierAudioScreen(),
    SupplierPdfScreen(),
    SupplierVideoScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Store',
          style: GoogleFonts.abyssinicaSil(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 50),
        child: ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            itemBuilder: (BuildContext, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => pages[index]));
                },
                child: Stack(children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    decoration: BoxDecoration(
                      color: colorarray[index],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Center(
                    child: Column(
                        children: [
                          Icon(
                            icons[index],
                            color: Colors.black,
                            size: 80,
                          ),
                          Text(
                            list[index],
                            style: GoogleFonts.abyssinicaSil(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 25
                            ),
                          ),
                        ]),
                  ),
                ]),
              );
            }),
      ),
    );
  }
}
