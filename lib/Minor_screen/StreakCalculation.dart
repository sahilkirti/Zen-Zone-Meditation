import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class MeditationStreak extends StatefulWidget {
  @override
  _MeditationStreakState createState() => _MeditationStreakState();
}

class _MeditationStreakState extends State<MeditationStreak> {
  int _meditationStreak = 0;
  final DateTime today = DateTime.now();
  @override
  void initState() {
    super.initState();
    _calculateMeditationStreak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xffeafddd),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Statistic',
          style: GoogleFonts.abyssinicaSil(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffeafddd), Color(0xffcff6e7) , Color(0xff41baf2)],
            ),
          ),
          child: Column(children: [
            MyHeatMaps(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black , width: 2),
                  borderRadius: BorderRadius.circular(5)),
              child: TableCalendar(
                calendarStyle: CalendarStyle(defaultTextStyle: TextStyle(color: Colors.black)),
                  locale: 'en_us',
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(color: Colors.black),
                      titleCentered: true),
                  focusedDay: today,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 10, 16)),
              margin: EdgeInsets.all(10),
            ),
          ]),
        ),
      ),
    );
  }

  void _calculateMeditationStreak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the last meditation date from SharedPreferences
    String? lastMeditationDate = prefs.getString('lastMeditationDate');

    if (lastMeditationDate == null) {
      // If there is no last meditation date, set the streak to 0
      setState(() {
        _meditationStreak = 0;
      });
    } else {
      // Calculate the difference between the last meditation date and today's date
      DateTime lastDate = DateTime.parse(lastMeditationDate);
      DateTime now = DateTime.now();
      Duration difference = now.difference(lastDate);

      // If the difference is less than or equal to 1 day, increase the streak
      if (difference.inDays <= 1) {
        setState(() {
          _meditationStreak = prefs.getInt('meditationStreak') ?? 0;
          _meditationStreak++;
        });

        // Save the new streak and last meditation date to SharedPreferences
        prefs.setInt('meditationStreak', _meditationStreak);
        prefs.setString('lastMeditationDate', now.toString());
      } else {
        // If the difference is more than 1 day, reset the streak
        setState(() {
          _meditationStreak = 0;
        });
        prefs.setInt('meditationStreak', _meditationStreak);
        prefs.remove('lastMeditationDate');
      }
    }
  }
}

class MyHeatMaps extends StatelessWidget {
  const MyHeatMaps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeatMap(
        datasets:
        {
          DateTime(2023, 4, 17): 30,
        },
        size: 30,
        defaultColor: Colors.white,
        textColor: Colors.black,
        colorMode: ColorMode.opacity,
        startDate: DateTime.now(),
        fontSize: 15,
        margin: EdgeInsets.all(9),
        endDate: DateTime.now().add(Duration(days: 40)),
        showText: true,
        scrollable: true,
        colorsets: {
          1: Colors.green,
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        });
  }
}
