import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/feature/navigation/model/bottom_bar_model.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/utils/size_util.dart';

class MyBottomBarItem {
  static final MyBottomBarItem _instance = MyBottomBarItem._internal();

  factory MyBottomBarItem() {
    return _instance;
  }

  MyBottomBarItem._internal();

  static List<BottomBarModel> bottomBatItems = [
    BottomBarModel(
      title: 'Home',
      icon: Icons.home_rounded,
      selectedIcon: Icons.home_rounded,
      action: GestureDetector(
          onTap: () => Get.toNamed(Routes.SCANQR),
          child: SvgPicture.asset(SvgAssets.scanQR)),
    ),
    BottomBarModel(
      title: 'Report',
      icon: Icons.bar_chart_outlined,
      selectedIcon: Icons.bar_chart_rounded,
    ),
    BottomBarModel(
      title: 'Task',
      icon: Icons.task_rounded,
      selectedIcon: Icons.task_rounded,
    ),
    BottomBarModel(
      title: 'Leave',
      icon: Icons.work_off_rounded,
      selectedIcon: Icons.work_off_rounded,
    ),
    BottomBarModel(
      title: 'Profile',
      icon: Icons.person_rounded,
      selectedIcon: Icons.person_rounded,
      action: GestureDetector(
        onTap: () => Get.toNamed(Routes.POINT),
        child: Container(
          width: SizeUtils.scale(22, MediaQuery.of(Get.context!).size.width),
          height: SizeUtils.scale(22, MediaQuery.of(Get.context!).size.width),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            SvgAssets.coin,
          ),
        ),
      ),
    ),
  ];
}
