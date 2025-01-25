import 'package:atko_user_app/screen/cours/cours_page.dart';
import 'package:atko_user_app/screen/home/home_page.dart';
import 'package:atko_user_app/screen/paymart/paymart_page.dart';
import 'package:atko_user_app/screen/profil/profile_page.dart';
import 'package:atko_user_app/screen/test/test_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    HomePage(),
    PaymartPage(),
    CoursPage(),
    const TestPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        width: Get.width,
        height: Get.height,
        color: Color(0xffffffff),
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color(0xff0961F5),
        items: [
          BottomNavigationBarItem(
            backgroundColor: const Color(0xffffffff),
            icon: Image.asset('assets/images/icon/home.png',width: 24.0,height: 24,),
            label: 'Asosiy',
            activeIcon: Image.asset('assets/images/icon/home_active.png',width: 24.0,height: 24.0,),
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color(0xffffffff),
            icon: Image.asset('assets/images/icon/paymart.png',width: 24.0,height: 24,),
            label: 'To\'lovlar',
            activeIcon: Image.asset('assets/images/icon/paymart_active.png',width: 24.0,height: 24.0,),
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color(0xffffffff),
            icon: Image.asset('assets/images/icon/cours.png',width: 24.0,height: 24,),
            label: 'Online kurslar',
            activeIcon: Image.asset('assets/images/icon/cours_active.png',width: 24.0,height: 24.0,),
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color(0xffffffff),
            icon: Image.asset('assets/images/icon/test.png',width: 24.0,height: 24,),
            label: 'Testlar',
            activeIcon: Image.asset('assets/images/icon/test_active.png',width: 24.0,height: 24.0,),
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color(0xffffffff),
            icon: Image.asset('assets/images/icon/profile.png',width: 24.0,height: 24,),
            label: 'Profil',
            activeIcon: Image.asset('assets/images/icon/profile_active.png',width: 24.0,height: 24.0,),
          ),
        ],
      ),
    );
  }
}
