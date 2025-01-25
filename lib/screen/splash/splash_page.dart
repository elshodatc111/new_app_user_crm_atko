import 'package:atko_user_app/screen/login/login_page.dart';
import 'package:atko_user_app/screen/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  Future<void> _checkTokenAndNavigate() async {
    final storage = GetStorage();
    String? token = storage.read('token');
    await Future.delayed(const Duration(seconds: 2));
    if (token != null && token.isNotEmpty) {
      Get.offAll(() => MainPage());
    } else {
      Get.offAll(() => LoginPage());
    }
  }
  @override
  Widget build(BuildContext context) {
    _checkTokenAndNavigate();
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Image.asset('assets/images/logo/logo_03.png',fit: BoxFit.contain,),
        ),
      ),
    );
  }
}
