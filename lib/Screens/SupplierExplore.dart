import 'package:final2/galleries/_ambientSound.dart';
import 'package:final2/galleries/_focus.dart';
import 'package:final2/galleries/_free.dart';
import 'package:final2/galleries/_podcast.dart';
import 'package:final2/galleries/_productivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/Fakesearch.dart';
import '../galleries/_deepFocus.dart';
import '../galleries/_kids.dart';
import '../galleries/_sleep.dart';

class SupplierExplore extends StatefulWidget {
  const SupplierExplore({Key? key}) : super(key: key);

  @override
  State<SupplierExplore> createState() => _SupplierExploreState();
}

class _SupplierExploreState extends State<SupplierExplore> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      animationDuration: Duration(milliseconds: 500),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: fakesearch(),
          elevation: 0.0,
          backgroundColor: Colors.white,
          bottom: TabBar(
              padding: EdgeInsets.only(left: 12),
              isScrollable: true,
              indicatorColor: Colors.black,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.black , width: 1.5),
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
        body:  TabBarView(
          children: [
            FocusGallery(),
            PodcastGallery(),
            SleepGallery(),
            DeepGallery(),
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

