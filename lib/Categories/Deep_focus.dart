import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Minor_screen/SubCategoryScreen.dart';

class DeepScreen extends StatefulWidget {
  const DeepScreen({Key? key}) : super(key: key);

  @override
  State<DeepScreen> createState() => _DeepScreenState();
}

class _DeepScreenState extends State<DeepScreen> {
  var colorArray = [
    Color(0xfffeeac0),
    Color(0xff7147e8),
    Color(0xffcafef6),
    Color(0xffb3a0cf),
    Color(0xfff3c664),
    Color(0xfffebde5),
    Colors.amber,
    Colors.deepOrangeAccent
  ];

  var Track = [
    'Track0',
    'Track1',
    'Track2',
    'Track3',
    'Track4',
    'Track5',
    'Track6',
    'Track7',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 7,
              crossAxisSpacing: 7,
              children: List.generate(
                Track.length,
                    (index) => InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryProduct(SubCategoryName: Track[index] , index: index,)));
                  },
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorArray[index],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Positioned(
                      top: 175,
                      left: 10,
                      child: Text(
                        Track[index],
                        style: GoogleFonts.abyssinicaSil(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

