import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CoursPages extends StatefulWidget {
  final String name;

  const CoursPages({super.key, required this.name});

  @override
  State<CoursPages> createState() => _CoursPagesState();
}

class _CoursPagesState extends State<CoursPages> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/watch?v=H4tFOht5klk',
      )!,
      flags: YoutubePlayerFlags(
        autoPlay: false, // Avtomatik ijroni yoqish
        mute: false, // Ovozni yoqish
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Online Kurslar",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff0961F5),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 1,
            itemBuilder: (ctx, index) {
          return Card(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready.');
              },
            ),
          );
        },),
      ),
    );
  }
}
