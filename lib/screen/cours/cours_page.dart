import 'package:atko_user_app/screen/cours/cours_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import intl package

class CoursPage extends StatefulWidget {
  @override
  State<CoursPage> createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  final Dio _dio = Dio();
  final storage = GetStorage();
  List<dynamic> courses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPaymart();
  }

  Future<void> fetchPaymart() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _dio.get(
        'https://atko.tech/test_atko_crm/public/api/courss',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${storage.read('token')}',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        setState(() {
          courses = response.data['cours'];
        });
      } else {
        Get.snackbar(
          'Xatolik',
          response.data['message'] ?? 'Maʼlumotlarni olishda xatolik yuz berdi',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Xatolik',
        "Tarmoqda xatolik yuz berdi.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatDate(String dateStr) {
    try {
      // Parse the incoming date string into a DateTime object
      DateTime date = DateTime.parse(dateStr);
      // Format the DateTime object into the desired format (day-month-year)
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      // In case of any error, return the original string
      return dateStr;
    }
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
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : courses.isEmpty
              ? Center(child: Text('No courses available'))
              : Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount:
                        courses.length, // Use the length of fetched courses
                    itemBuilder: (c, i) {
                      var course = courses[i];
                      var name = course['name'] ?? 'N/A';
                      var muddat = course['muddat'] ?? 'N/A';
                      var formattedMuddat = formatDate(muddat);
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        color: Colors.white,
                        child: OnlineCours(
                          name: name,
                          lengths: formattedMuddat, // Pass the formatted date
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}

class OnlineCours extends StatelessWidget {
  final String name;
  final String lengths;

  const OnlineCours({
    super.key,
    required this.name,
    required this.lengths,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/banner/banner_online.png',
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              name,
              style: TextStyle(
                color: Color(0xff202244),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Online kurs muddati: "),
                  Text(lengths), // Show the formatted course duration
                ],
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
          ],
        ),
      ),
      onPressed: () {
        Get.to(CoursPages(name: name));
      },
    );
  }
}
