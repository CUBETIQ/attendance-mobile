import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/console/console.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/home/model/check_in_model.dart';
import 'package:attendance_app/feature/home/service/index.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/utils/role.dart';
import 'package:attendance_app/utils/time_formater.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static HomeController get to => Get.find();
  late TabController? tabController;
  RxString getUserRole = "WWWWW".obs;
  DateTime date = DateTime.now();
  RxBool isCheckedIn = false.obs;
  RxBool disableCheckOut = true.obs;
  Rxn<String> checkInTime = Rxn<String>(null);
  Rxn<String> checkOutTime = Rxn<String>(null);
  Rxn<int> dateInMiliSecond = Rxn<int>(null);

  @override
  void onInit() {
    super.onInit();
    initTabWithRole();
  }

  void initTabWithRole() {
    if (NavigationController.to.getUserRole.value == Role.staff) {
      tabController = null;
    } else {
      tabController = TabController(length: 2, vsync: this);
    }
  }

  Future<void> checkIn() async {
    isCheckedIn.value = true;
    disableCheckOut.value = false;
    try {
      CheckInModel input = CheckInModel(
        checkInDateTime: DateTime.now().millisecondsSinceEpoch,
        checkInType: null,
        checkInStatus: null,
      );
      var checkIn = await HomeService().checkIn(input);
      checkInTime.value = DateFormatter().formatTime(
        DateTime.fromMillisecondsSinceEpoch(checkIn.checkInDateTime!),
      );
      getCheckInBottomSheet(Get.context!, image: working);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> checkOut() async {
    isCheckedIn.value = false;
    disableCheckOut.value = true;
    checkOutTime.value = DateFormatter().formatTime(DateTime.now());
    getCheckOutBottomSheet(
      Get.context!,
      image: leaving,
    );
  }

  void initDate(DateTime date) {
    DateTime now = DateTime.now();
  }
}
