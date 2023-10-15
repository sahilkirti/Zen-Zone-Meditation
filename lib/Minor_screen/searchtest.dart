// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
//
// class SearchPage extends StatefulWidget {
//   const SearchPage({Key? key}) : super(key: key);
//
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   final TextEditingController _searchController = TextEditingController();
//   List<DocumentSnapshot> _bookResults = [];
//   List<DocumentSnapshot> _productResults = [];
//   List<DocumentSnapshot> _combinedResults = [];
//   bool _searching = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Future<void> _search(String query) async {
//     setState(() {
//       _searching = true;
//     });
//
//     QuerySnapshot bookSnapshot = await FirebaseFirestore.instance
//         .collection('Book_detail')
//         .where('Bookname', isGreaterThanOrEqualTo: query)
//         .where('Bookname', isLessThanOrEqualTo: query + '\uf8ff')
//         .get();
//
//     QuerySnapshot productSnapshot = await FirebaseFirestore.instance
//         .collection('products')
//         .where('proname', isGreaterThanOrEqualTo: query)
//         .where('proname', isLessThanOrEqualTo: query + '\uf8ff')
//         .get();
//
//     setState(() {
//       _bookResults = bookSnapshot.docs;
//       _productResults = productSnapshot.docs;
//       _combinedResults = [..._bookResults, ..._productResults] ;
//       _searching = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search View'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: const InputDecoration(
//                 hintText: 'Search',
//                 suffixIcon: Icon(Icons.search),
//               ),
//               onChanged: (query) {
//                 if (query.isNotEmpty) {
//                   _search(query);
//                 }
//               },
//             ),
//           ),
//           Expanded(
//             child: _searching
//                 ? const Center(
//               child: CircularProgressIndicator(),
//             )
//                 : ListView(
//               children: _combinedResults
//                   .map<Widget>((e) => SearchModel(e: e))
//                   .toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class SearchModel extends StatelessWidget {
//   final dynamic e;
//   const SearchModel({Key? key, required this.e}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final String? imageUrl = e['Bookimages'] != null
//         ? e['Bookimages'][0]
//         : e['proimages'] != null
//         ? e['proimages'][0]
//         : null;
//
//     final String title = e['Bookname'] != null
//         ? e['Bookname']
//         : e['Productname'] != null
//         ? e['Productname']
//         : e['proname'] != null
//         ? e['proname']
//         : '';
//
//     final String subtitle = e['Bookdesc'] != null
//         ? e['Bookdesc']
//         : e['Productdesc'] != null
//         ? e['Productdesc']
//         : e['BookAuthor'] != null
//         ? e['BookAuthor']
//         : e['prodesc'] != null
//         ? e['prodesc']
//         : '';
//
//     return InkWell(
//       onTap: () {},
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(12)),
//           height: 100,
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: SizedBox(
//                     height: 100,
//                     width: 100,
//                     child: imageUrl != null
//                         ? Image(
//                       image: NetworkImage(imageUrl),
//                       fit: BoxFit.cover,
//                     )
//                         : Container(),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Flexible(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                         title,
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                         style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       Text(
//                         subtitle,
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 2,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:final2/Modal/ProductModal/ProductModalBook1.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late Stream<QuerySnapshot> _booksStream;
  late Stream<QuerySnapshot> _productsStream;

  @override
  void initState() {
    super.initState();
    _booksStream =
        FirebaseFirestore.instance.collection('Book_detail').snapshots();
    _productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            filled: true,
            fillColor: Colors.grey[200],
            hintStyle: TextStyle(color: Colors.black),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _booksStream = FirebaseFirestore.instance
                  .collection('Book_detail')
                  .where('Bookname', isGreaterThanOrEqualTo: value)
                  .snapshots();
              _productsStream = FirebaseFirestore.instance
                  .collection('products')
                  .where('proname', isGreaterThanOrEqualTo: value)
                  .snapshots();
            });
          },
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _booksStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot e = snapshot.data!.docs[index];
                    final String? imageUrl =
                        e['Bookimages'] != null ? e['Bookimages'][0] : null;
                    final String title = e['Bookname'];
                    final String subtitle = e['Bookdesc'] != null
                        ? e['BookAuthor']
                        : e['BookAuthor'];
                    return ListTile(
                      leading:
                          imageUrl != null ? Image.network(imageUrl) : null,
                      title: Text(title),
                      subtitle: Text(subtitle),
                    );
                  },
                );
              },
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.black,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _productsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot e = snapshot.data!.docs[index];
                    final String? imageUrl =
                        e['proimages'] != null ? e['proimages'][0] : SizedBox();
                    final String title = e['proname'];
                    final String subtitle =
                        e['prodesc'] != null ? e['prodesc'] : e['proprice'];
                    return ListTile(
                      leading:
                          imageUrl != null ? Image.network(imageUrl) : SizedBox(),
                      title: Text(title),
                      subtitle: Text(subtitle),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
