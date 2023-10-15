import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Minor_screen/SearchScreen.dart';

class fakesearchpdf extends StatelessWidget {
  const fakesearchpdf({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchScreen()));
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search_sharp,
                color: Colors.black,
              ),
            ),
            Text(
              'What are you looking for?',
              style: GoogleFonts.abyssinicaSil(
                  fontWeight: FontWeight.w500, color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.only(right: 2),
              child: Container(
                height: 40,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text(
                      'Search',
                      style: GoogleFonts.abyssinicaSil(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
