import 'package:final2/Categories/Ambient_sound.dart';
import 'package:final2/Categories/Deep_focus.dart';
import 'package:final2/Categories/Free.dart';
import 'package:final2/Categories/Kids.dart';
import 'package:final2/Categories/Podcast.dart';
import 'package:final2/Categories/Productivity.dart';
import 'package:final2/Categories/Sleep.dart';
import 'package:final2/Categories/Focus1.dart';
import 'package:final2/galleries/_ambientSound.dart';
import 'package:final2/galleries/_focus.dart';
import 'package:final2/galleries/_free.dart';
import 'package:final2/galleries/_kids.dart';
import 'package:final2/galleries/_productivity.dart';
import 'package:final2/galleries/_sleep.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Minor_screen/SearchScreen.dart';
import '../Widgets/Fakesearch.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);
  static const String id = "/Explore_screen";
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      animationDuration: Duration(milliseconds: 500),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: fakesearch(),
          elevation: 0.0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            physics: ClampingScrollPhysics(),
              padding: EdgeInsets.only(left: 12),
              isScrollable: true,
              indicatorColor: Colors.black,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.shade300,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.black,
              tabs: [
                Repeated_tabs(label: 'Focus'),
                Repeated_tabs(label: 'Podcast'),
                Repeated_tabs(label: 'Sleep'),
                Repeated_tabs(label: 'Deep Focus'),
                Repeated_tabs(label: 'Kids'),
                Repeated_tabs(label: 'Productivity'),
                Repeated_tabs(label: 'Ambient Sound'),
                Repeated_tabs(label: 'Free'),
              ]),
        ),
        body: const TabBarView(
          children: [
            FocusGallery(),
            PodcastScreen(),
            SleepGallery(),
            DeepScreen(),
            KidsGallery(),
            ProductivityGallery(),
            AmbientGallery(),
            FreeGallery(),
          ],
        ),
      ),
    );
  }
}

class Repeated_tabs extends StatelessWidget {
  final String label;
  const Repeated_tabs({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: GoogleFonts.abyssinicaSil(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}


