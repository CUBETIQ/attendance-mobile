import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/feature/navigation/service/index.dart';
import 'package:timesync/feature/onboard/model/onboard_model.dart';
import 'package:timesync/notification/notification_service.dart';
import 'package:timesync/routes/app_pages.dart';

class AppPermissionController extends GetxController {
  static AppPermissionController get to => Get.find();

  PageController? pageController;
  final onBoardList = [
    OnBoardModel(
      title: 'Enable Notification',
      description:
          'Allow timesync to send you notifications to keep you updated on your attendance and time tracking activities. Stay informed and never miss a beat with timesync.',
      image: SvgAssets.notificationPermission,
    ),
    OnBoardModel(
      title: 'Enable Location',
      description:
          'timesync uses your location to provide accurate time tracking and attendance management. Enable location services to ensure seamless time tracking and attendance management.',
      image: SvgAssets.locationPermission,
    ),
  ];
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void maybeLater() {
    if (currentIndex.value == 0) {
      pageController!.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }

  Future<void> onTapButton() async {
    if (currentIndex.value == 0) {
      await NotificationIntegration.requestPermission()
          .then((value) => pageController!.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              ));
    } else {
      await NavigationService()
          .getCurrentLocation()
          .then((value) => Get.offNamed(Routes.LOGIN));
    }
  }

  void onChange(int index) {
    currentIndex.value = index;
  }
}
