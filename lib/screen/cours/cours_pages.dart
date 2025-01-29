import 'package:atko_user_app/screen/cours/play_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoursPages extends StatefulWidget {
  final List<dynamic> videolar;
  final String name;

  const CoursPages({super.key, required this.videolar, required this.name});

  @override
  State<CoursPages> createState() => _CoursPagesState();
}

class _CoursPagesState extends State<CoursPages> {
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
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff0961F5),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.name ?? "No Name",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.videolar.length,
              itemBuilder: (context, index) {
                return LessinItem(
                  lessin: widget.videolar[index]['lessen_name'] ?? "",
                  url: widget.videolar[index]['video_url'] ?? "",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LessinItem extends StatelessWidget {
  final String lessin;
  final String url;

  const LessinItem({super.key, required this.lessin, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        border: Border.all(
          color: Colors.blueGrey,
        ),
      ),
      child: TextButton(
        onPressed: () {
          print(lessin);
          print(url);
          Get.to(() => PlayVideo(name: lessin??"",url: url??"https://www.youtube.com/watch?v=6h-92GwZ2cw",),);
        },
        child: Text(lessin),
      ),
    );
  }
}
