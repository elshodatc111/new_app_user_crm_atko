import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class PaymartPage extends StatefulWidget {
  const PaymartPage({super.key});

  @override
  State<PaymartPage> createState() => _PaymartPageState();
}

class _PaymartPageState extends State<PaymartPage> {
  final Dio _dio = Dio();
  final storage = GetStorage();
  List<dynamic> paymart = [];
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
        'https://atko.tech/test_atko_crm/public/api/paymart',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${storage.read('token')}',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        setState(() {
          paymart = response.data['date'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To'lovlar",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff0961F5),
      ),
      body: RefreshIndicator(
        onRefresh: fetchPaymart,  // Bu yerda onRefresh metodini ishlatamiz
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : paymart.isEmpty
            ? const Center(
          child: Text(
            'Maʼlumotlar topilmadi',
            style: TextStyle(fontSize: 18),
          ),
        )
            : Container(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: paymart.length,
            itemBuilder: (context, index) {
              var item = paymart[index];
              return Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff0961F5),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: PaymartItem(
                  amount: item['summa'],
                  type: item['type'],
                  date: item['created_at'],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class PaymartItem extends StatelessWidget {
  final String amount;
  final String type;
  final String date;

  const PaymartItem({
    super.key,
    required this.amount,
    required this.type,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    // Parsing the created_at date to display it in a user-friendly format
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = '${parsedDate.year}-${parsedDate.month}-${parsedDate.day} ${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}';

    return ListTile(
      title: Text(amount),
      subtitle: Text(formattedDate),
      leading: const Icon(
        Icons.account_balance_wallet_rounded,
        color: Color(0xff0961F5),
      ),
      trailing: Text(type),
    );
  }
}
