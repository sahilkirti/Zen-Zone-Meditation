import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageProfileScreen extends StatelessWidget {
  const ManageProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title:Text(
          'Manage-Profile',
          style: GoogleFonts.abyssinicaSil(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new ,color: Colors.black,),
        ),
      ),
    );
  }
}
