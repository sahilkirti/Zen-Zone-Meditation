import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DestinationCarousal extends StatefulWidget {
  const DestinationCarousal({Key? key}) : super(key: key);

  @override
  State<DestinationCarousal> createState() => _DestinationCarousalState();
}

class _DestinationCarousalState extends State<DestinationCarousal> {
  @override
  Widget build(BuildContext context) {
    List<Color> colorArray = [
      Color(0xfffeeac0),
      Color(0xff7147e8),
      Color(0xffcafef6),
    ];

    var sliderName = [
      'Slider1',
      'Slider2',
      'Slider3',
    ];

    List<Widget> container(int index) {
      return colorArray
          .map(
            (e) => ClipRect(
              child: Container(
                decoration: BoxDecoration(
                    color: colorArray[index],
                    // image: DecorationImage(
                    //   image: NetworkImage()
                    // ),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          )
          .toList();
    }

    final List<String> image = [
      'images/Blur/quotes1.jpg',
      'images/Blur/Quotes3.jpg',
      'images/Blur/Quotes4.jpg',
      'images/Blur/Qutoe2.jpg',
    ];
    return Container(
      color : Color(0xffeafddd),
      padding: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          CarouselSlider(
              items: image
                  .map((e) => Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 0,
                                  spreadRadius: 1),
                            ],
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffeafddd),
                            border: Border.all(color: Colors.black, width: 1.5),
                            image: DecorationImage(
                                image: AssetImage(e), fit: BoxFit.cover)),
                      ))
                  .toList(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
                autoPlayCurve: Curves.bounceInOut,
              ))
        ],
      ),
    );
  }
}
