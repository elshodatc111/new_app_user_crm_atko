import 'package:atko_user_app/screen/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'groups_page.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Kurslar',
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff0961F5),
        actions: [
          Obx(() {
            int balans = GetStorage().read('balans') ?? 0;
            return TextButton(
              onPressed: controller.isLoadingBalans.value
                  ? null
                  : controller.getBalans,
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: balans >= 0 ? Colors.white : Colors.red,
                  ),
                  SizedBox(width: 4.0),
                  controller.isLoadingBalans.value
                      ? SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    ),
                  )
                      : Text(
                    "$balans so'm",
                    style: TextStyle(
                      color: balans >= 0 ? Colors.white : Colors.red,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.groups.isEmpty) {
          return Center(child: Text("Ma'lumot topilmadi"));
        } else {
          return ListView.builder(
            itemCount: controller.groups.length,
            itemBuilder: (context, index) {
              final group = controller.groups[index];
              return ItemWidget(
                id: group['id'],
                name: group['name'],
                start: group['start'],
                end: group['end'],
              );
            },
          );
        }
      }),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final int id;
  final String name;
  final String start;
  final String end;

  const ItemWidget({
    super.key,
    required this.id,
    required this.name,
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/banner/banner_home.png',
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              name,
              style: TextStyle(
                color: Color(0xff202244),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("Boshlanish vaqti"),
                    Text(start),
                  ],
                ),
                Column(
                  children: [
                    Text("Tugash vaqti"),
                    Text(end),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
          ],
        ),
      ),
      onPressed: () {
        Get.to(GroupsPage(id: id));
      },
    );
  }
}
