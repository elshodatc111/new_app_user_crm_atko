import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'groups_controller.dart';  // GroupsController import qilish

class GroupsPage extends StatelessWidget {
  final int id;

  const GroupsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final GroupsController controller = Get.put(GroupsController());

    // Ma'lumotlarni olish
    controller.fetchGroups(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kurs',
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff0961F5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.groupDetails.isEmpty) {
            return const Center(
              child: Text(
                'Maʼlumotlar topilmadi',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.all(12.0),
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/banner/banner_home.png',
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    controller.groupDetails['guruh_name'] ?? 'Nomaʼlum',
                    style: const TextStyle(
                      color: Color(0xff202244),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  InfoRow(
                    title: "Boshlanish vaqti:",
                    value: controller.groupDetails['guruh_start'] ?? 'Nomaʼlum',
                  ),
                  InfoRow(
                    title: "Tugash vaqti:",
                    value: controller.groupDetails['guruh_end'] ?? 'Nomaʼlum',
                  ),
                  InfoRow(
                    title: "Darslar vaqti:",
                    value: controller.groupDetails['guruh_vaqt'] ?? 'Nomaʼlum',
                  ),
                  InfoRow(
                    title: "Dars xonasi:",
                    value: controller.groupDetails['room'] ?? 'Nomaʼlum',
                  ),
                  InfoRow(
                    title: "O'qituvchi:",
                    value: controller.groupDetails['techer'] ?? 'Nomaʼlum',
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    "Dars kunlari",
                    style: TextStyle(
                      color: Color(0xff202244),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.times.length,
                      itemBuilder: (context, index) {
                        return InfoRow(
                          title: "${index + 1}-dars",
                          value: controller.times[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
