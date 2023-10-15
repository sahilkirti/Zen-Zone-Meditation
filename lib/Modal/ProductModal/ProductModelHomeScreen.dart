import 'package:final2/ProfileList/Favourites.dart';

// import 'package:final2/Provider/ProductProvider.dart';
import 'package:final2/Screens/MusicPlayer/Musicplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductModelHomeScreen extends StatelessWidget {
  final dynamic products;

  const ProductModelHomeScreen({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => MusicPlayer(
        //               AuthorName: 'XYZ',
        //               titleName: products['proname'],
        //               image: products['proimages'][0],
        //             )));
      },
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                // child: Container(
                //   constraints: BoxConstraints(minHeight: 80, maxWidth: 200),
                //   child: Image(
                //     image: NetworkImage(products['proimages'][0]),
                //   ),
                // ),
                child: Container(
                  constraints: BoxConstraints(minHeight: 200, maxWidth: 200),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 20,
                          offset: Offset(2, 2),
                          spreadRadius: 20),
                    ],
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(products['proimages'][0]),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(children: [
                Align(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            products['proname'],
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.abyssinicaSil(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // Row(children: [
                        //         IconButton(
                        //           onPressed: () {
                        //
                        //           },
                        //           icon: Icon(
                        //             Icons.favorite_border_outlined,
                        //             color: Colors.red,
                        //             size: 18,
                        //           ),
                        //         ),
                        //         Icon(
                        //           Icons.lock,
                        //           color: Colors.grey.shade800,
                        //           size: 18,
                        //         )
                        //       ])
                      ]),
                  alignment: Alignment.topLeft,
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
