import 'package:timesync360/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync360/core/database/isar/service/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find();
  final LocalStorageController localDataService =
      LocalStorageController.getInstance();

  RxBool isDarkMode = false.obs;
  @override
  void onInit() {
    super.onInit();
    initFunction();
  }

  Future<void> initFunction() async {
    final data = await localDataService.get();
    isDarkMode.value = data?.darkTheme ?? false;
  }

  Future<void> changeTheme(bool value) async {
    isDarkMode.value = value;
    if (value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
    await IsarService().saveLocalData(darkTheme: isDarkMode.value);
  }
}
