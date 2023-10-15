import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/PaymentScreens/Payment_1_screen.dart';
import 'package:final2/Screens/MusicPlayer/Musicplayer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import '../../Minor_screen/Edit/EditProductSupplierAudio.dart';
import '../../Provider/FavouriteProvider.dart';
import '../../Provider/Product Provider.dart';

class ProductModelFree extends StatefulWidget {
  final dynamic products;

  const ProductModelFree({
    super.key,
    required this.products,
  });

  @override
  State<ProductModelFree> createState() => _ProductModelFreeState();
}

class _ProductModelFreeState extends State<ProductModelFree> {
  int _totalRatings = 0;
  double _averageRating = 0;

  @override
  void initState() {
    super.initState();
    _getProductRatings();
  }

  void _getProductRatings() async {
    // retrieve all the reviews for the product
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.products['proid'])
        .collection('review')
        .get();

    // calculate the total number of ratings and sum up all the ratings
    int totalRatings = snapshot.docs.length;
    double totalRatingValue = 0;
    snapshot.docs.forEach((doc) {
      totalRatingValue += doc['rate'];
    });

    // calculate the average rating
    double averageRating = totalRatingValue / totalRatings;

    setState(() {
      _totalRatings = totalRatings;
      _averageRating = averageRating;
    });
  }

  // late final Stream<QuerySnapshot> reviewstream = FirebaseFirestore.instance
  //   .collection('products')
  //   .doc(widget.products['proid'])
  //   .collection('reviews')
  //   .snapshots();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (ctx) => StreamBuilder(
        //             stream: FirebaseFirestore.instance
        //                 .collection('orders')
        //                 .where('cid',
        //                 isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        //                 .where('proid', isEqualTo: widget.products['proid'])
        //                 .snapshots(),
        //             builder: (context, snapshot) {
        //               if (snapshot.connectionState == ConnectionState.waiting) {
        //                 return Center(
        //                   child: CircularProgressIndicator(
        //                     color: Colors.black,
        //                   ),
        //                 );
        //               } else if (snapshot.data!.docs.isEmpty) {
        //                 return PlaceOrder(
        //                   products: widget.products,
        //                   titleName: widget.products['proname'],
        //                   image: widget.products['proimages'][0],
        //                   Price: widget.products['price'].toStringAsFixed(2),
        //                 );
        //               } else {
        //                 return MusicPlayer(
        //                   titleName: widget.products['proname'],
        //                   image: widget.products['proimages'][0],
        //                   AuthorName: 'riddhish',
        //                   product: widget.products,
        //                   price: widget.products['price'].toStringAsFixed(2),
        //                 );
        //               }
        //             })));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MusicPlayer(
                      titleName: widget.products['proname'],
                      image: widget.products['proimages'][0],
                      AuthorName: 'riddhish',
                      product: widget.products,
                      price: widget.products['price'].toStringAsFixed(2),
                    )));
      },
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(3, 3),
                    spreadRadius: 0.3,
                    color: Colors.black)
              ],
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(6, 6, 6, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(0)),
                  constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
                  child: Image(
                    image: NetworkImage(widget.products['proimages'][0]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(0)),
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Center(
                                child: Text(
                                  widget.products['proname'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.abyssinicaSil(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            widget.products['sid'] ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProductSupplierAudio(
                                                    item: widget.products,
                                                  )));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                  )
                                : Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          context
                                                      .read<Wish>()
                                                      .getWishItems
                                                      .firstWhereOrNull(
                                                          (Product) =>
                                                              Product
                                                                  .documentId ==
                                                              widget
                                                                      .products[
                                                                  'proid']) !=
                                                  null
                                              ? context.read<Wish>().removeThis(
                                                  widget.products['proid'])
                                              : context
                                                  .read<Wish>()
                                                  .addWishItem(
                                                      widget
                                                          .products['proname'],
                                                      widget.products['price'],
                                                      widget.products[
                                                          'proimages'],
                                                      widget.products['proid'],
                                                      widget.products['sid']);
                                        },
                                        icon: context
                                                    .watch<Wish>()
                                                    .getWishItems
                                                    .firstWhereOrNull(
                                                        (Product) =>
                                                            Product
                                                                .documentId ==
                                                            widget.products[
                                                                'proid']) !=
                                                null
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : Icon(
                                                Icons.favorite_outline_outlined,
                                                color: Colors.black,
                                              ),
                                      ),
                                    ],
                                  )
                          ]),
                        ]),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
// Widget reviewall() {
//   return StreamBuilder<QuerySnapshot>(
//       stream: reviewstream, builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     if (snapshot.data!.docs.isEmpty) {
//       return Center(child: Text('No review yet'));
//     }
//   });
// }
}

// Divider(
//   color: Colors.black,
//   thickness: 1,
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Text(
//       (' ₹') +
//           widget.products['price'].toStringAsFixed(2),
//       maxLines: 2,
//       overflow: TextOverflow.ellipsis,
//       style: GoogleFonts.abyssinicaSil(
//         color: Colors.black,
//         fontWeight: FontWeight.normal,
//       ),
//     ),
//     widget.products['sid'] ==
//             FirebaseAuth.instance.currentUser!.uid
//         ? IconButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           EditProductSupplierAudio(
//                             item: widget.products,
//                           )));
//             },
//             icon: Icon(
//               Icons.edit,
//               color: Colors.black,
//             ),
//           )
//         : Row(
//             children: [
//               IconButton(
//                 onPressed: () {
//                   context
//                               .read<Wish>()
//                               .getWishItems
//                               .firstWhereOrNull(
//                                   (Product) =>
//                                       Product
//                                           .documentId ==
//                                       widget.products[
//                                           'proid']) !=
//                           null
//                       ? context
//                           .read<Wish>()
//                           .removeThis(
//                               widget
//                                   .products['proid'])
//                       : context
//                           .read<Wish>()
//                           .addWishItem(
//                               widget.products[
//                                   'proname'],
//                               widget
//                                   .products['price'],
//                               widget.products[
//                                   'proimages'],
//                               widget
//                                   .products['proid'],
//                               widget.products['sid']);
//                 },
//                 icon: context
//                             .watch<Wish>()
//                             .getWishItems
//                             .firstWhereOrNull(
//                                 (Product) =>
//                                     Product
//                                         .documentId ==
//                                     widget.products[
//                                         'proid']) !=
//                         null
//                     ? Icon(
//                         Icons.favorite,
//                         color: Colors.red,
//                       )
//                     : Icon(
//                         Icons
//                             .favorite_outline_outlined,
//                         color: Colors.black,
//                       ),
//               ),
//               // StreamBuilder(
//               //     stream: FirebaseFirestore.instance
//               //         .collection('orders')
//               //         .where('cid',
//               //             isEqualTo: FirebaseAuth
//               //                 .instance
//               //                 .currentUser!
//               //                 .uid)
//               //         .where('proid',
//               //             isEqualTo: widget
//               //                 .products['proid'])
//               //         .snapshots(),
//               //     builder: (context, snapshot) {
//               //       if (snapshot.connectionState ==
//               //           ConnectionState.waiting) {
//               //         return SizedBox();
//               //       } else if (snapshot
//               //           .data!.docs.isEmpty) {
//               //         return Icon(
//               //           Icons.lock,
//               //           color: Colors.grey.shade800,
//               //         );
//               //       } else {
//               //         return SizedBox();
//               //       }
//               //     }),
//             ],
//           )
//   ],
// )
