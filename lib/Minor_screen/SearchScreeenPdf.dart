import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchInput = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: CupertinoSearchTextField(
          autofocus: true,
          autocorrect: true,
          onChanged: (value) {
            setState(() {
              searchInput = value;
            });
          },
        ),
      ),
      body: searchInput == ""
          ? Center(
        child: AnimatedTextKit(
          isRepeatingAnimation: true,
          animatedTexts: [
            TypewriterAnimatedText(
              'Search For Meditation ...',
              textStyle: GoogleFonts.abyssinicaSil(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              speed: const Duration(milliseconds: 200),
            ),
          ],
        ),
      )
          : StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collectionGroup('products')
            .where('proname', isGreaterThanOrEqualTo: searchInput.toLowerCase())
            .where('proname', isLessThan: searchInput.toLowerCase() + 'z')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> productSnapshot) {
          if (productSnapshot.connectionState == ConnectionState.waiting) {
            return Material(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            );
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collectionGroup('Book_detail')
                .where('Bookname', isGreaterThanOrEqualTo: searchInput.toLowerCase())
                .where('Bookname', isLessThan: searchInput.toLowerCase() + 'z')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> bookSnapshot) {
              if (bookSnapshot.connectionState == ConnectionState.waiting) {
                return Material(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              }

              final productResult =
              productSnapshot.data!.docs.where((e) => e['proname']
                  .toLowerCase()
                  .contains(searchInput.toLowerCase()));
              final bookResult =
              bookSnapshot.data!.docs.where((e) => e['title']
                  .toLowerCase()
                  .contains(searchInput.toLowerCase()));

              final combinedResult = [productResult, bookResult];

              return ListView(
                children:
                productResult.map<Widget>((e) => SearchModel(e: e)).toList(),
              );
            },
          );
        },
      ),
    );
  }
}

class SearchModel extends StatelessWidget {
  final dynamic e;
  const SearchModel({Key? key, required this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          height: 100,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image(
                        image: NetworkImage(e['proimages'][0]),
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        e['proname'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        e['prodesc'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
