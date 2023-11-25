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

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    controller.forward();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed(Routes.LOGIN);
  }
}
