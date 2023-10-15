import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

class BottomModel extends StatefulWidget {
  final String titleName;
  final String image;
  final String Price;
  final dynamic products;

  const BottomModel(
      {Key? key,
      required this.titleName,
      required this.image,
      required this.Price,
      required this.products})
      : super(key: key);
  static const String id = '/Bottom_model_sheet';

  @override
  State<BottomModel> createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Unlock the Beat",
          style: GoogleFonts.abyssinicaSil(
              fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            FontAwesomeIcons.backward,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .12,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .37,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(widget.image)),
                  border: Border.all(color: Colors.black)),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                widget.titleName,
                style: GoogleFonts.abyssinicaSil(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Colors.black),
              ),
            ),
            SlideAction(
              borderRadius: 5,
              innerColor: Colors.white,
              outerColor: Colors.black,
              textStyle: TextStyle(fontSize: 18, color: Colors.white),
              onSubmit: () {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => Payment_Screen(
                //               products: widget.products,
                //               Price: widget.Price,
                //               image: widget.image,
                //               titleName: widget.titleName,
                //             )));
              },
              text: "       Slide to Pay " + ('₹') + widget.Price,
            )
          ],
        ),
      ),
    );
  }
}
