import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/database/isar/model/lcoal_storage_model.dart';
import 'package:timesync360/core/database/isar/service/isar_service.dart';
import 'package:timesync360/feature/onboard/model/onboard_model.dart';
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
      image: SvgAssets.onboard1,
    ),
    OnBoardModel(
      title: 'Boost Productivity',
      description:
          'TimeSync360 helps you stay organized by providing a user-friendly platform for managing your daily attendance. Enhance your productivity with precise time tracking and insightful reports.',
      image: SvgAssets.onboard2,
    ),
    OnBoardModel(
      title: 'Achieve Your Goals',
      description:
          'Set, track, and conquer your time management goals effortlessly with TimeSync360. Whether it\'s meeting project deadlines or achieving personal milestones, we\'ve got your time goals covered.',
      image: SvgAssets.onboard3,
    ),
  ];
  RxInt currentIndex = 0.obs;
  LocalStorageModel? localStorageData = LocalStorageModel();

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void onTapButton() async {
    if (currentIndex.value == 2) {
      localStorageData?.isFirstTime = false;
      await IsarService().saveLocalData(input: localStorageData);
      Get.offNamed('/login');
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
