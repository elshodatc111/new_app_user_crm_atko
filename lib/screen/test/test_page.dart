import 'package:atko_user_app/screen/test/test_show.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
        'https://atko.tech/test_atko_crm/public/api/test',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          testData = List<Map<String, dynamic>>.from(response.data['test']);
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
          "Testlar",
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
            guruh_id: item['guruh_id'] ?? 0,
            name: item['name'] ?? 'Noma’lum',
            count: item['count'] ?? 0,
            ball: item['ball'] ?? 0,
            trues: item['trues'] ?? 0,
            test: item,
          );
        },
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String name;
  final int guruh_id;
  final int count;
  final int trues;
  final int ball;
  final Map<String, dynamic> test;

  const Item({
    super.key,
    required this.guruh_id,
    required this.name,
    required this.count,
    required this.trues,
    required this.ball,
    required this.test,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print(test);
        Get.to(TestShow(testlar: test,),);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff0961F5)),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(color: Color(0xff202244), fontSize: 16.0, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [Text("Urinishlar Soni"), Text("$count")]),
                Column(children: [Text("To'g'ri Javob"), Text("$trues")]),
                Column(children: [Text("Hisoblandi"), Text("$ball ball")]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
