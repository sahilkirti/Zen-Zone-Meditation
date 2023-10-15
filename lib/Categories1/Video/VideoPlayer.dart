// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'MovieModel.dart';
//
// class VideoPlayerCustom extends StatefulWidget
// {
//
//   final dynamic products;
//
//   const VideoPlayerCustom({Key? key, required this.products,}): super(key:key);
//   @override
//   State<VideoPlayerCustom> createState() => _VideoPlayerCustomState();
//
// }
//
// class _VideoPlayerCustomState extends State<VideoPlayerCustom> {
//   late BetterPlayerController _betterPlayerController;
//   final GlobalKey _betterPlayerKey = GlobalKey();
//
//   @override
//   void initState() {
//     const  BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
//         aspectRatio: 16 / 9,
//         fit: BoxFit.contain
//     );
//     BetterPlayerDataSource dataSource = BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         widget.products['Prodesc']
//
//     );
//     _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
//     _betterPlayerController.setupDataSource(dataSource);
//     _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           const SizedBox(height: 8,),
//           Expanded(child: AspectRatio(
//             aspectRatio: 16 / 9,
//             child: BetterPlayer(
//               key: _betterPlayerKey,
//               controller: _betterPlayerController,),
//           ),),
//           //  Text('butterfly',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 45),)
//         ],),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerCustom extends StatefulWidget {
  final dynamic products;

  const VideoPlayerCustom({Key? key,required this.products}): super(key:key);

  @override
  VideoPlayerCustomState createState() => VideoPlayerCustomState();
}

class VideoPlayerCustomState extends State<VideoPlayerCustom> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    String videoId = YoutubePlayer.convertUrlToId(widget.products['Yurl'])!;
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 8,),
          Expanded(
            child: YoutubePlayer(
              controller: _youtubePlayerController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}