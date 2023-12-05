import 'package:attendance_app/core/widgets/console/console.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/utils/role.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static HomeController get to => Get.find();
  late TabController? tabController;
  RxString getUserRole = "WWWWW".obs;
  DateTime date = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    initTabWithRole();
  }

  void initTabWithRole() {
    if (NavigationController.to.getUserRole.value == Role.staff) {
      tabController = null;
      Console.log("Staff", tabController);
    } else {
      tabController = TabController(length: 2, vsync: this);
      Console.log("Admin", tabController);
    }
  }
}
