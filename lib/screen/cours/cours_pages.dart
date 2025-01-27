import 'package:atko_user_app/screen/cours/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoursPages extends StatefulWidget {
  final List<dynamic> videolar;

  const CoursPages({super.key, required this.videolar});

  @override
  State<CoursPages> createState() => _CoursPagesState();
}

class _CoursPagesState extends State<CoursPages> {
  int currentIndex = 0;

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.videolar[currentIndex]['lessen_name'] ?? "No Name",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {

            },
            child: Text(
              widget.videolar[currentIndex]['video_url'],
            ),
          ),
          SizedBox(height: 16.0),

          Expanded(
            child: ListView.builder(
              itemCount: widget.videolar.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    "${index + 1}-dars:",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                  ),
                  title: Text(
                    widget.videolar[index]['lessen_name'] ?? " ",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          // Oldinga va orqaga tugmalari
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Oldinga tugmasi
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (currentIndex > 0) {
                    setState(() {
                      currentIndex--;
                    });
                  }
                },
              ),
              // Orqaga tugmasi
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (currentIndex < widget.videolar.length - 1) {
                    setState(() {
                      currentIndex++;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
