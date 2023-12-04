import 'package:attendance_app/core/database/isar/controller/local_storage_controller.dart';
import 'package:attendance_app/core/database/isar/entities/local_storage.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static SplashController get to => Get.find();

  final double frameRate = 70;
  final String title = 'Time Glitch';

  late AnimationController controller;
  late Animation<double> animation;
  final LocalStorageController localDataService = LocalStorageController();
  Rx<LocalStorage> localData = LocalStorage().obs;

  @override
  void onInit() {
    super.onInit();
    initLocalDb();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
    init();
  }

  Future<void> initLocalDb() async {
    final data = await localDataService.get();
    localData.value = data ?? LocalStorage();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));

    if (localData.value.isActivated == false ||
        localData.value.isActivated == null) {
      Get.offNamed(Routes.ACTIVATION);
    } else if (localData.value.accessToken != null) {
      Get.offNamed(Routes.NAVIGATION);
    } else if (localData.value.isFirstTime == false) {
      Get.offNamed(Routes.LOGIN);
    } else {
      Get.offNamed(Routes.ONBOARD);
    }
  }
}
