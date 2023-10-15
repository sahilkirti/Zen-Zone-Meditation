import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../Modal/WishModel.dart';
import '../Provider/FavouriteProvider.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouritesScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
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
              'Favourites',
              style: GoogleFonts.abyssinicaSil(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black),
            ),
            actions: [
              if (context.watch<Wish>().getWishItems.isEmpty)
                const SizedBox()
              else
                IconButton(
                  onPressed: () {
                    CupertinoAlertDialog(
                      title: new Text("Clear Favourites"),
                      content: new Text(
                          "Are you sure you want to clear Favourites?"),
                      actions: [
                        CupertinoDialogAction(
                            isDefaultAction: true,
                            child: Text('Yes'),
                            onPressed: () {
                              context.read<Wish>().clearWishlist();
                              Navigator.pop(context);
                            }),
                        CupertinoDialogAction(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                )
            ],
          ),
          body: context.watch<Wish>().getWishItems.isNotEmpty
              ? const WishItems()
              : const EmptyWishlist(),
        ),
      ),
    );
  }
}

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(60, 100, 60, 10),
          child: Container(
            height: MediaQuery.of(context).size.height * .37,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/Blur/NoResult.jpg')),
                border: Border.all(color: Colors.black, width: 2)
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Center(
              child: Text(
                'No Favourites',
                textAlign: TextAlign.center,
                style: GoogleFonts.abyssinicaSil(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class WishItems extends StatelessWidget {
  const WishItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(
      builder: (context, wish, child) {
        return ListView.builder(
            itemCount: wish.count,
            itemBuilder: (context, index) {
              final product = wish.getWishItems[index];
              return WishlistModel(product: product);
            });
      },
    );
  }
}
