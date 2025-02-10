import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final Dio _dio = Dio();
  final storage = GetStorage();

  var isLoadingBalans = false.obs;
  var isLoading = false.obs;
  var groups = [].obs;

  @override
  void onInit() {
    super.onInit();
    getBalans();
    fetchGroups();
  }

  Future<void> getBalans() async {
    isLoadingBalans.value = true;
    try {
      final response = await _dio.get(
        'https://atko.tech/TestAtkoCrm/public/api/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${storage.read('token')}',
          },
        ),
      );

      if (response.statusCode == 200) {
        storage.write('balans', response.data['balans']['balans']);
      }
    } catch (e) {
      Get.snackbar(
        'Xatolik',
        "Tarmoqda xatolik yuz berdi.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingBalans.value = false;
    }
  }

  Future<void> fetchGroups() async {
    isLoading.value = true;
    try {
      final response = await _dio.get(
        'https://atko.tech/test_atko_crm/public/api/home',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${storage.read('token')}',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        groups.value = response.data['group'];
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
      isLoading.value = false;
    }
  }
}
