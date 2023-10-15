import 'dart:io';

import 'package:flutter/material.dart';

import 'MovieListItem.dart';
import 'MovieModel.dart';
import 'VideoScreen.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    List<Movie> movies=Movie.movies;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
            clipper: _CustomClipper(),
            child:Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFF000B49),
              child:const Center(
                  child: Text('Explore',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)) ,
            )
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80,),
            const Padding(
              padding:  EdgeInsets.all(11.0),
              child: Text('Featured Videos',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            const  SizedBox(height: 6,),
            for(final movie in movies)
              InkWell(
                onTap: (){
                  //Navigator.push(context,MaterialPageRoute(builder: (context)=>MovieScreen(movie: movie))
                  //);
                },
                child: MovieListItem(
                    imageUrl:movie.thumbUrl,
                    name:movie.name
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height=size.height;
    double width=size.width;

    var path=Path();

    path.lineTo(0,height-50);
    path.quadraticBezierTo(width/2,height,width,height-50);
    path.lineTo(width,0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
