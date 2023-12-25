import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/database/isar/service/isar_service.dart';
import 'package:attendance_app/feature/onboard/model/onboard_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardController extends GetxController {
  static OnBoardController get to => Get.find();
  PageController? pageController;
  List<OnBoardModel> onBoardList = [
    OnBoardModel(
      title: 'Seamless Time Tracking',
      description:
          'Effortlessly track your work hours and manage your time with TimeSync360. Say goodbye to manual record-keeping and welcome a smarter way to log your attendance.',
      image: onboard1,
    ),
    OnBoardModel(
      title: 'Boost Productivity',
      description:
          'TimeSync360 helps you stay organized by providing a user-friendly platform for managing your daily attendance. Enhance your productivity with precise time tracking and insightful reports.',
      image: onboard2,
    ),
    OnBoardModel(
      title: 'Achieve Your Goals',
      description:
          'Set, track, and conquer your time management goals effortlessly with TimeSync360. Whether it\'s meeting project deadlines or achieving personal milestones, we\'ve got your time goals covered.',
      image: onboard3,
    ),
  ];
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void onTapButton() async {
    if (currentIndex.value == 2) {
      Get.offNamed('/login');
      await IsarService().saveLocalData(isFirstTime: false);
    } else {
      pageController!.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void onChange(int index) {
    currentIndex.value = index;
  }
}
