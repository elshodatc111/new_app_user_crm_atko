import 'package:atko_user_app/screen/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _logout() async {
    final storage = GetStorage();
    await storage.erase();
    Get.offAll(() => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff0961F5),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 40.0,
              horizontal: 50,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xff0961F5),
                  child: Image.asset('assets/images/icon/user.png'),
                ),
                SizedBox(height: 8.0),
                Text(
                  storage.read('name') ?? 'Ism mavjud emas',
                  style: TextStyle(
                    color: Color(0xff7B7B7B),
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Login: ${storage.read('email') ?? 'Mavjud emas'}',
                  style: TextStyle(
                    color: Color(0xff7B7B7B),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Telefon raqam: +998 ${storage.read('phone') ?? 'Mavjud emas'}',
                  style: TextStyle(
                    color: Color(0xff7B7B7B),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Manzil: ${storage.read('addres') ?? 'Mavjud emas'}',
                  style: TextStyle(
                    color: Color(0xff7B7B7B),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                backgroundColor: Color(0xffFE1101),
              ),
              child: const Text(
                'Chiqish',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
