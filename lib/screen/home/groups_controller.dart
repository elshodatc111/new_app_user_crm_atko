import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class GroupsController extends GetxController {
  final Dio _dio = Dio();
  final storage = GetStorage();

  var times = <dynamic>[];
  var groupDetails = <String, dynamic>{}.obs;
  var isLoading = true.obs;

  Future<void> fetchGroups(int id) async {
    try {
      final response = await _dio.get(
        'https://atko.tech/test_atko_crm/public/api/home/show/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${storage.read('token')}',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['status'] == true) {
        times = response.data['data'].cast<dynamic>();
        groupDetails.value = response.data['group'];
        isLoading.value = false;
      } else {
        Get.snackbar(
          'Xatolik',
          response.data['message'] ?? 'Maʼlumotlarni olishda xatolik yuz berdi',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar(
        'Xatolik',
        "Tarmoqda xatolik yuz berdi.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
    }
  }
}
