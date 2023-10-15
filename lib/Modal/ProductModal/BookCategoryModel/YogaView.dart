import 'package:final2/CategoryBook/_Yoga.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class YogaViewScreen extends StatefulWidget {
  const YogaViewScreen({Key? key}) : super(key: key);

  @override
  State<YogaViewScreen> createState() => _YogaViewScreenState();
}

class _YogaViewScreenState extends State<YogaViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            FontAwesomeIcons.backward,
            color: Colors.black,
            size: 18,
          ),
        ),
        elevation: 0.0,
        title: Text(
          'Yoga Books',
          style: GoogleFonts.abyssinicaSil(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        ),
      ),
      body: YogaGallery(),
    );
  }
}
