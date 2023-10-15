import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../CategoryBook/_Health.dart';

class HealthViewScreen extends StatefulWidget {
  const HealthViewScreen({Key? key}) : super(key: key);

  @override
  State<HealthViewScreen> createState() => _HealthViewScreenState();
}

class _HealthViewScreenState extends State<HealthViewScreen> {
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
          'Health Books',
          style: GoogleFonts.abyssinicaSil(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        ),
      ),
      body: HealthGallery(),
    );
  }
}
