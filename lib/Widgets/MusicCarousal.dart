import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Musiccarousal extends StatefulWidget {
  const Musiccarousal({Key? key}) : super(key: key);

  @override
  State<Musiccarousal> createState() => _MusiccarousalState();
}

class _MusiccarousalState extends State<Musiccarousal> {
  @override
  Widget build(BuildContext context) {
    List<Color> colorArray = [
      Color(0xfffeeac0),
      Color(0xff7147e8),
      Color(0xffcafef6),
    ];

    List<String> images = [
      'images/MusicPlayer/justin.jpeg',
      'images/MusicPlayer/m1.jpeg',
      'images/MusicPlayer/m2.jpeg',
      'images/MusicPlayer/m3.jpeg',
    ];

    var sliderName = [
      'Slider1',
      'Slider2',
      'Slider3',
    ];
    return Scaffold(
      body: Center(
        child: CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage = images[index];
              return BuildImage(urlImage, index);
            },
            options: CarouselOptions(height: 100)),
      ),
    );
  }
}

Widget BuildImage(String urlImage, int index) => Container(
  margin: EdgeInsets.symmetric(horizontal: 12),
  color: Colors.grey,
);
