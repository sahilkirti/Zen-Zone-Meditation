import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../Provider/FavouriteProvider.dart';
import 'musicmodel.dart';

class MusicPlayer extends StatefulWidget {
  final String titleName;
  final String image;
  final String AuthorName;
  final dynamic product;
  final String price;

  MusicPlayer(
      {Key? key,
      required this.titleName,
      required this.image,
      required this.AuthorName,
      required this.product,
      required this.price})
      : super(key: key);
  static const String id = '/Music_player';

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late String tap;

  List<Mp3> audio = [
    Mp3(
        title: "SongA",
        publisher: "A",
        duration: Duration(minutes: 2, seconds: 30),
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
        thumbnail:
            "https://cdn.pixabay.com/photo/2021/11/09/21/29/sculpture-6782444__480.jpg"),
    Mp3(
        title: "SongB",
        publisher: "B",
        duration: Duration(minutes: 1, seconds: 30),
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
        thumbnail:
            "https://cdn.pixabay.com/photo/2022/11/10/20/45/guitar-7583677__480.jpg"),
    Mp3(
        title: "SongC",
        publisher: "C",
        duration: Duration(minutes: 2, seconds: 23),
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
        thumbnail:
            "https://cdn.pixabay.com/photo/2020/06/08/19/07/violin-5275762__480.jpg"),
    Mp3(
        title: "SongD",
        publisher: "D",
        duration: Duration(minutes: 2, seconds: 14),
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
        thumbnail:
            "https://cdn.pixabay.com/photo/2018/09/04/17/24/cover-3654282__480.jpg"),
  ];

  // List<PaletteColor?> bgColors = [];

  @override
  void initState() {
    super.initState();
    // bgColors = [];
    // addColor();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  int index = 0;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      centerTitle: true,
      title: Column(
        children: [
          Text(
            widget.product['proname'],
            style: TextStyle(color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              "CURRENTLY PLAYING",
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
          )
        ],
      ),
      leading: InkWell(
        onTap: (){
          setState(() {
            audioPlayer.stop();
          });
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            context
                .read<Wish>()
                .getWishItems
                .firstWhereOrNull((Product) =>
            Product.documentId ==
                widget.product['proid']) !=
                null
                ? context.read<Wish>().removeThis(widget.product['proid'])
                : context.read<Wish>().addWishItem(
                widget.product['proname'],
                widget.product['price'],
                widget.product['proimages'],
                widget.product['proid'],
                widget.product['sid']);
          },
          icon:context
              .watch<Wish>()
              .getWishItems
              .firstWhereOrNull((Product) =>
          Product.documentId ==
              widget.product['proid']) !=
              null ? Icon(
            Icons.favorite,
            color: Colors.red,
          ) : Icon(
            Icons.favorite_outline_outlined,
            color: Colors.black,
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    final avlHeight = (MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.product['proimages'][0]),
                          fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: avlHeight * 0.60,
                ),
                Positioned(
                    bottom: 13,
                    right: 20,
                    left: 20,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.35),
                              border: Border.all(color: Colors.white38),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: avlHeight * 0.11,
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.product['proname'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "By " + audio[index].publisher,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )
                              ],
                            ))),
                      ),
                    ))
              ]),
              SizedBox(
                height: avlHeight * 0.1,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                height: avlHeight * 0.35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Slider(
                        activeColor: Colors.black,
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) async {
                          final position = Duration(seconds: value.toInt());
                          await audioPlayer.seek(position);
                        }),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatTime(position)),
                          Text(formatTime(duration - position))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                index = (index - 1) % audio.length;
                                audioPlayer.play(widget.product['AudioUrl']);
                              });
                            },
                            icon: Icon(
                              Icons.skip_previous,
                              size: 40,
                            )),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 30,
                          child: IconButton(
                            icon: isPlaying
                                ? Icon(
                                    Icons.pause,
                                    size: 30,
                                  )
                                : Icon(
                                    Icons.play_arrow,
                                    size: 30,
                                  ),
                            onPressed: () async {
                              // CollectionReference orderRef =
                              // FirebaseFirestore.instance
                              //     .collection('Heatmaps');
                              // tap = Uuid().v4();
                              // await orderRef.doc(tap).set({
                              //   'tap' : true,
                              //   'time' : DateTime.now()
                              // });
                              isPlaying
                                  ? audioPlayer.pause()
                                  : audioPlayer.play(widget.product['AudioUrl']);
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                index = (index + 1) % audio.length;
                                audioPlayer.play(widget.product['AudioUrl']);
                              });
                            },
                            icon: Icon(
                              Icons.skip_next,
                              size: 40,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: avlHeight * 0.05,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // void addColor() async {
  //   for (var it in audio) {
  //     final PaletteGenerator pg = await PaletteGenerator.fromImageProvider(
  //       NetworkImage(it.thumbnail),
  //     );
  //     bgColors.add(pg.lightVibrantColor == null
  //         ? PaletteColor(Colors.white, 2)
  //         : pg.lightVibrantColor);
  //   }
  // }
}
