import 'package:atko_user_app/screen/test/test_check.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TestShow extends StatefulWidget {
  final Map<String, dynamic> testlar;

  const TestShow({
    super.key,
    required this.testlar,
  });

  @override
  State<TestShow> createState() => _TestShowState();
}

class _TestShowState extends State<TestShow> {
  late List<Map<String, dynamic>> queth;
  int count = 0;
  int answer = 0;
  bool isLoading = false;

  final boxsss = GetStorage();
  String? token;

  @override
  void initState() {
    super.initState();
    token = boxsss.read('token');
    queth = (widget.testlar['testlar'] as List).map((e) {
      return {
        "Savol": e['savol'],
        "Javob": e['javob']
      };
    }).toList();
  }

  void asnwerQuetion(bool status) {
    setState(() {
      count++;
      if (status) {
        answer = answer + 1;
      }
    });
  }

  void checkResults() async {
    if (token == null) {
      print("Error: Token not found.");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      const String url = 'https://atko.tech/test_atko_crm/public/api/test/check';
      final response = await Dio(BaseOptions(
        followRedirects: true,
        validateStatus: (status) => status! < 500,
      )).post(
        url,
        data: {
          "guruh_id": widget.testlar['guruh_id'],
          "tugri_count": answer,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // Use the initialized token
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Response Data: ${response.data}");
        Get.to(TestCheck(trues: response.data['true'].toString(),ball: response.data['ball'].toString(),),);
      } else {
        print("Error: ${response.statusCode} - ${response.statusMessage}");
      }
    } on DioError catch (e) {
      print("DioError: ${e.message}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Testlar",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff0961F5),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              "${count != queth.length ? count + 1 : queth.length} / ${queth.length}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: count < queth.length
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              queth[count]['Savol'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff202244),
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 20.0),
            ...List.generate(queth[count]['Javob'].length, (index) {
              return Container(
                margin: const EdgeInsets.only(top: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: TextButton(
                  onPressed: () =>
                      asnwerQuetion(queth[count]['Javob'][index]['status']),
                  child: Text(
                    queth[count]['Javob'][index]['test'],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              );
            })
          ],
        )
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                onPressed: checkResults,
                label: const Text("Tekshirish"),
                icon: const Icon(Icons.restart_alt_sharp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
