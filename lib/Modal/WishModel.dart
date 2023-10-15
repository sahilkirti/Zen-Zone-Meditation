import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Provider/FavouriteProvider.dart';
import '../Provider/Product Provider.dart';

class WishlistModel extends StatelessWidget {
  const WishlistModel({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(6),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              ),
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(4, 10, 10, 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width/2.5,
                        constraints: BoxConstraints(minHeight: 100, maxHeight: 200 , maxWidth: 200 , minWidth: 200),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            //border: Border.all(color: Colors.black, width: 2)
                        ),
                        child: Image(
                          image: NetworkImage(product.imagesUrl.first),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.width / 3.5,
                            decoration: BoxDecoration(
                                //border: Border.all(width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Align(
                                    child: Center(
                                      child: Text(
                                        product.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.abyssinicaSil(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                  IconButton(onPressed: (){
                                    context.read<Wish>().removeItem(product);
                                  }, icon: Icon(Icons.delete))
                                ]),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
