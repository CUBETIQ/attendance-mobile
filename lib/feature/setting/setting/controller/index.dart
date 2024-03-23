import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync/core/database/isar/model/local_storage_model.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find();
  final localDataService = LocalStorageController.getInstance();
  final isDarkMode = Get.isDarkMode.obs;
  LocalStorageModel? localStorageData = LocalStorageModel();

  @override
  void onInit() {
    super.onInit();
    initFunction();
  }

  Future<void> initFunction() async {
    isDarkMode.value = Get.isDarkMode;
  }

  Future<void> changeTheme(bool value) async {
    isDarkMode.value = value;
    localStorageData?.darkTheme = value;
    if (value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
    await IsarService().saveLocalData(input: localStorageData);
  }

  Future<void> changeConfirmation(bool value) async {
    await IsarService()
        .saveLocalData(input: LocalStorageModel(confirmCheckIn: value));
    AppConfig.confirmCheckIn.value = value;
  }
}
