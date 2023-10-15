import 'package:final2/Minor_screen/SubCategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Focus1Screen extends StatefulWidget {
  const Focus1Screen({Key? key}) : super(key: key);

  @override
  State<Focus1Screen> createState() => _Focus1ScreenState();
}

class _Focus1ScreenState extends State<Focus1Screen> {
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
    'Focus 1',
    'Focus 2',
    'Focus 3',
    'Focus 4',
    'Focus 5',
    'Focus 6',
    'Focus 7',
    'Focus 8',
  ];

  var Images = [
    'images/Focus/image1.jpg',
    'images/Focus/image2.jpg',
    'images/Focus/image3.jpg',
    'images/Focus/image4.jpg',
    'images/Focus/image5.jpg',
    'images/Focus/image6.jpg',
    'images/Focus/image7.jpg',
    'images/Focus/image1.jpg',
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubCategoryProduct(
                                SubCategoryName: Track[index],
                                index: index)));
                  },
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(Images[index]) , fit: BoxFit.cover),
                          color: colorArray[index],
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    // Positioned(
                    //   top: 175,
                    //   left: 10,
                    //   child: Text(
                    //     Track[index],
                    //     style: GoogleFonts.abyssinicaSil(
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
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
