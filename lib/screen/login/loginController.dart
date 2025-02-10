import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:atko_user_app/screen/main_page.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Dio _dio = Dio();
  var isLoading = false.obs;

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Xatolik',
        "Barcha maydonlarni to'ldiring",
        backgroundColor: Color(0xff0961F5),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await _dio.post(
        'https://atko.tech/TestAtkoCrm/public/api/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        final storage = GetStorage();
        storage.write('token', response.data['token']);
        storage.write('name', response.data['data']['name']);
        storage.write('email', response.data['data']['email']);
        storage.write('phone', response.data['data']['phone']);
        storage.write('addres', response.data['data']['addres']);
        storage.write('balans', response.data['data']['balans']);
        Get.offAll(() => MainPage());
      } else {
        Get.snackbar(
          'Xatolik',
          "Login yoki parol noto'g'ri.",
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
      isLoading.value = false;
    }
  }
}
