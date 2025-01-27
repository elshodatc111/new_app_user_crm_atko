import 'package:atko_user_app/screen/cours/cours_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class CoursPage extends StatefulWidget {
  @override
  State<CoursPage> createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  List<Map<String, dynamic>> testData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final box = GetStorage();
    final token = box.read('token');

    try {
      var response = await Dio().get(
        'https://atko.tech/test_atko_crm/public/api/courss',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          testData = List<Map<String, dynamic>>.from(response.data['cours']);
          isLoading = false;
        });
      }
    } catch (e) {
      print('Xatolik: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kurslar",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: Color(0xff0961F5),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: testData.length,
        itemBuilder: (context, index) {
          var item = testData[index];
          return Item(
            name: item['name'] ?? 'Noma’lum',
            times: item['muddat'] ?? 'No Date',
            cours: item['video'], // Ensure this is a List<Map<String, dynamic>> type
          );
        },
      ),
    );
  }

  String formatDate(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      print('Sana formatlashda xatolik: $e');
      return dateStr;
    }
  }
}

class Item extends StatefulWidget {
  final String name;
  final String times;
  final List<dynamic> cours; // Change this to List<dynamic> because it's a list of videos

  const Item(
      {super.key,
        required this.name,
        required this.times,
        required this.cours,});
  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(8.0),
        ),
        width: Get.width,
        child: Column(
          children: [
            Image.asset(
              'assets/images/banner/banner_online.png',
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "${widget.name}",
              style: TextStyle(
                color: Color(0xff202244),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Azolik muddati"),
                  Text("${widget.times}"), // Sana formatlangan holda
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
      onPressed: () {
        print(widget.cours);
        // Pass the list of courses (widget.cours) to CoursPages.
        Get.to(() => CoursPages(videolar: widget.cours));
      },
    );
  }
}
