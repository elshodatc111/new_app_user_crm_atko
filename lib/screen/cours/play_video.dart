import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideo extends StatefulWidget {
  final String name;
  final String url;
  const PlayVideo({super.key, required this.name, required this.url});

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        widget.url,
      )!,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff0961F5),
      ),
      body: Container(
        padding: EdgeInsets.all(4.0),
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () {
            print('Player is ready.');
          },
        ),
      ),
    );
  }
}
