import 'package:final2/Categories1/Audio.dart';
import 'package:final2/Categories1/E-Book.dart';
import 'package:final2/Categories1/Video/Video.dart';
import 'package:final2/Categories1/Video/Video1.dart';
import 'package:final2/Widgets/Fakesearch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Categories1/Books/Books.dart';
import '../Categories1/Download.dart';
import 'Explore.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        animationDuration: Duration(milliseconds: 500),
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: fakesearch(),
            elevation: 0.0,
            backgroundColor: Colors.white,
            bottom: TabBar(
                padding: EdgeInsets.only(left: 12),
                isScrollable: true,
                automaticIndicatorColorAdjustment: true,
                indicatorColor: Colors.black,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black),
                  color: Colors.grey.shade300,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.black,
                splashFactory: NoSplash.splashFactory,
                tabs: [
                  Repeated_tabs1(label: 'Audio' , iconData: Icons.multitrack_audio_sharp,),
                  Repeated_tabs1(label: 'Video' , iconData: Icons.video_library_outlined,),
                  Repeated_tabs1(label: 'E-book' , iconData: Icons.picture_as_pdf,),
                  Repeated_tabs1(label: 'Community' , iconData: Icons.chat,),
                ]),
          ),
          body: TabBarView(children: [
            AudioScreen(),
            // VideoScreen(),
            VideoExplore(),
            // EbookScreen(),
            Books(),
            DownloadScreen(),
          ]),
        ));
  }
}

class Repeated_tabs1 extends StatelessWidget {
  final String label;
  final IconData iconData;
  const Repeated_tabs1({super.key, required this.label , required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(children: [
        Icon(iconData , color: Colors.black),
        SizedBox(width: 3,),
        Text(
          label,
          style: GoogleFonts.abyssinicaSil(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ]),
    );
  }
}
