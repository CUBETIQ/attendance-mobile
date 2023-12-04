import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/console/console.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/navigation/model/bottom_bar_model.dart';
import 'package:attendance_app/feature/navigation/service/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  RxInt selectedIndex = 0.obs;
  Rx<UserModel> user = UserModel().obs;
  List<String> titles = ['Home', 'Report', 'Profile'];
  List<BottomBarModel> items = [
    BottomBarModel(
      title: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
    ),
    BottomBarModel(
      title: 'Report',
      icon: Icons.bar_chart_outlined,
      selectedIcon: Icons.bar_chart_rounded,
    ),
    BottomBarModel(
      title: 'Profile',
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    fetchMe();
  }

  void onDestinationSelected(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchMe() async {
    try {
      user.value = await NavigationService().fetchMe();
      Console.log("User", user.value.toString());
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }
}
