import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/home/model/check_in_model.dart';
import 'package:attendance_app/feature/home/model/check_out_model.dart';
import 'package:attendance_app/feature/home/service/index.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/utils/types/role.dart';
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
  Rxn<int> startOfDay = Rxn<int>(null);
  Rxn<int> endOfDay = Rxn<int>(null);
  RxList<AttendanceModel> attendanceList = <AttendanceModel>[].obs;
  var isLoadingList = false.obs;

  @override
  void onInit() {
    super.onInit();
    initTabWithRole();
    initDate();
    getAttendance();
  }

  void initTabWithRole() {
    if (NavigationController.to.getUserRole.value == Role.staff) {
      tabController = null;
    } else {
      tabController = TabController(length: 2, vsync: this);
    }
  }

  Future<void> checkIn() async {
    try {
      CheckInModel input = CheckInModel(
        checkInDateTime: DateTime.now().millisecondsSinceEpoch,
        checkInType: null,
        checkInStatus: null,
      );
      AttendanceModel checkIn = await HomeService().checkIn(input);
      checkInTime.value = DateFormatter().formatTime(
        DateTime.fromMillisecondsSinceEpoch(checkIn.checkInDateTime!),
      );
      getAttendance();
      isCheckedIn.value = true;
      disableCheckOut.value = false;
      getCheckInBottomSheet(Get.context!, image: working);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> checkOut() async {
    try {
      CheckOutModel input = CheckOutModel(
        checkOutDateTime: DateTime.now().millisecondsSinceEpoch,
        checkOutType: null,
        checkOutStatus: null,
      );
      AttendanceModel checkOut = await HomeService().checkOut(input);
      checkOutTime.value = DateFormatter().formatTime(
        DateTime.fromMillisecondsSinceEpoch(checkOut.checkOutDateTime!),
      );
      getAttendance();
      isCheckedIn.value = false;
      disableCheckOut.value = true;
      checkOutTime.value = DateFormatter().formatTime(DateTime.now());
      getCheckOutBottomSheet(Get.context!, image: leaving);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getAttendance() async {
    isLoadingList.value = true;
    try {
      attendanceList.value = await HomeService().getAttendance(
        startDate: startOfDay.value,
        endDate: endOfDay.value,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoadingList.value = false;
    }
  }

  void initDate() {
    startOfDay.value = DateTime(date.year, date.month, date.day, 0, 0, 0)
        .millisecondsSinceEpoch;
    endOfDay.value = DateTime(date.year, date.month, date.day, 23, 59, 59)
        .millisecondsSinceEpoch;
  }
}
