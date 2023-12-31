import 'dart:async';
import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/model/summary_attendance_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/extensions/string.dart';
import 'package:attendance_app/feature/home/model/check_in_model.dart';
import 'package:attendance_app/feature/home/model/check_out_model.dart';
import 'package:attendance_app/feature/home/service/index.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/profile/profile/controller/index.dart';
import 'package:attendance_app/utils/attendance_status_validator.dart';
import 'package:attendance_app/utils/types_helper/attendance_method.dart';
import 'package:attendance_app/utils/types_helper/role.dart';
import 'package:attendance_app/utils/time_formater.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  static HomeController get to => Get.find();
  late TabController? tabController;
  RxString getUserRole = "WWWWW".obs;
  DateTime date = DateTime.now();
  RxBool isCheckedIn = false.obs;
  Rxn<String> checkInTime = Rxn<String>(null);
  Rxn<String> checkOutTime = Rxn<String>(null);
  Rxn<int> dateInMiliSecond = Rxn<int>(null);
  Rxn<int> startOfDay = Rxn<int>(null);
  Rxn<int> endOfDay = Rxn<int>(null);
  Rx<int> startOfMonth = 0.obs;
  Rx<int> endOfMonth = 0.obs;
  RxList<AttendanceModel> attendanceList = <AttendanceModel>[].obs;
  var isLoadingList = false.obs;
  RxString startHour = "8:00".obs;
  RxString endHour = "17:00".obs;
  Rxn<String> totalHour = Rxn<String>(null);
  RxString currentDate = "".obs;
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  RxBool isInRange = false.obs;
  RxBool isBreakTime = false.obs;
  Rxn<String> breakTimeTitle = Rxn<String>(null);
  Rx<UserModel> user = UserModel().obs;
  RxList<SummaryAttendanceModel> summaryAttendance =
      <SummaryAttendanceModel>[].obs;
  Rxn<String> name = Rxn<String>(null);
  var isLoadingSummary = false.obs;
  Rxn<int> totalAttendance = Rxn<int>(null);
  Rxn<int> totalAbsent = Rxn<int>(null);
  Rxn<int> totalLeave = Rxn<int>(null);

  @override
  void onInit() {
    super.onInit();
    initAnimation();
    initTabWithRole();
    initDate();
    getAttendance();
    checkBreakTime();
    getUsername();
    getSummarizeAttendance();
  }

  void onRefresh() {
    getAttendance();
    checkBreakTime();
    getSummarizeAttendance();
  }

  void initAnimation() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
  }

  void initTabWithRole() {
    if (NavigationController.to.getUserRole.value == Role.staff) {
      tabController = null;
    } else {
      tabController = TabController(length: 2, vsync: this);
    }
  }

  Future<void> checkIn() async {
    DateTime now = DateTime.now();
    if (now.hour > endHour.value.split(":").first.toInt()) {
      showErrorSnackBar("Error", "You can't check in after $endHour");
      return;
    } else {
      controller.forward();
      checkOutTime.value = null;
      totalHour.value = null;
      try {
        LocationModel location = LocationModel(
          lat: NavigationController.to.userLocation.value?.latitude,
          lng: NavigationController.to.userLocation.value?.longitude,
          inOffice: NavigationController.to.isInRange.value,
        );

        CheckInModel input = CheckInModel(
          checkInDateTime: now.millisecondsSinceEpoch,
          checkInType: AttendanceMethod.manual,
          checkInStatus:
              CheckInStatusValidator().getStatus(startHour.value, now),
          checkInLocation: location,
        );

        AttendanceModel checkIn = await HomeService().checkIn(input);
        checkInTime.value = DateFormatter().formatTime(
          DateTime.fromMillisecondsSinceEpoch(checkIn.checkInDateTime!),
        );
        getAttendance();
        await getSummarizeAttendance();
        if (Get.isRegistered<ProfileController>()) {
          ProfileController.to.getSummarizeAttendance();
        }
        isCheckedIn.value = true;
        getCheckInBottomSheet(Get.context!, image: working);
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response?.data["message"]);
        rethrow;
      }
    }
  }

  Future<void> checkOut() async {
    controller.forward();
    DateTime now = DateTime.now();
    try {
      LocationModel location = LocationModel(
        lat: NavigationController.to.userLocation.value?.latitude,
        lng: NavigationController.to.userLocation.value?.longitude,
        inOffice: NavigationController.to.isInRange.value,
      );

      CheckOutModel input = CheckOutModel(
        checkOutDateTime: now.millisecondsSinceEpoch,
        checkOutType: AttendanceMethod.manual,
        checkOutStatus: CheckOutStatusValidator().getStatus(endHour.value, now),
        checkOutLocation: location,
      );
      AttendanceModel checkOut = await HomeService().checkOut(input);
      checkOutTime.value = DateFormatter().formatTime(
        DateTime.fromMillisecondsSinceEpoch(checkOut.checkOutDateTime!),
      );
      getAttendance();
      isCheckedIn.value = false;
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
      if (attendanceList.isNotEmpty) {
        if (attendanceList.last.checkOutDateTime != null) {
          totalHour.value = DateFormatter().formatMinutes(
            attendanceList.last.duration!,
          );
        }
        checkInTime.value = DateFormatter().formatTime(
          DateTime.fromMillisecondsSinceEpoch(
            attendanceList.last.checkInDateTime!,
          ),
        );
        if (attendanceList.last.checkOutDateTime == null) {
          isCheckedIn.value = true;
        } else {
          checkOutTime.value = DateFormatter().formatTime(
            DateTime.fromMillisecondsSinceEpoch(
              attendanceList.last.checkOutDateTime!,
            ),
          );
          isCheckedIn.value = false;
        }
      } else {
        checkInTime.value = null;
        checkOutTime.value = null;
        totalHour.value = null;
        isCheckedIn.value = false;
      }
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoadingList.value = false;
    }
  }

  Future<void> getSummarizeAttendance() async {
    totalAbsent.value = 0;
    totalLeave.value = 0;
    totalAttendance.value = 0;
    try {
      summaryAttendance.value = await HomeService().getSummrizeAttendance(
        startDate: startOfMonth.value,
        endDate: endOfMonth.value,
      );

      for (var element in summaryAttendance) {
        totalAbsent.value =
            ((totalAbsent.value ?? 0) + (element.totalAbsent ?? 0));
        totalLeave.value =
            ((totalLeave.value ?? 0) + (element.totalLeave ?? 0));
        totalAttendance.value =
            ((totalAttendance.value ?? 0) + (element.totalAttendance ?? 0));
      }
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void initDate() {
    startOfDay.value = DateTime(date.year, date.month, date.day, 0, 0, 0)
        .millisecondsSinceEpoch;
    endOfDay.value = DateTime(date.year, date.month, date.day, 23, 59, 59)
        .millisecondsSinceEpoch;

    startOfMonth.value =
        DateTime(date.year, date.month, 1, 0, 0, 0).millisecondsSinceEpoch;

    endOfMonth.value = DateTime(date.year, date.month + 1, 0, 23, 59, 59)
        .millisecondsSinceEpoch;

    startHour.value =
        NavigationController.to.organization.value.configs?.startHour ?? "8:00";
    endHour.value =
        NavigationController.to.organization.value.configs?.endHour ?? "17:00";

    currentDate.value = DateFormat('E, MMM dd').format(date);
  }

  void checkBreakTime() {
    final time = DateTime.now().hour;
    final startBreakHour =
        NavigationController.to.startBreakTime.split(":")?.first;
    final endBreakHour = NavigationController.to.endBreakTime.split(":")?.first;
    if (time >= int.parse(startBreakHour ?? "0") &&
        time < int.parse(endBreakHour ?? "0")) {
      isBreakTime.value = true;
      breakTimeTitle.value = "Ongoing";
    } else if (time >= int.parse(endBreakHour ?? "0")) {
      isBreakTime.value = true;
      breakTimeTitle.value = "Finished";
    } else {
      isBreakTime.value = false;
      breakTimeTitle.value = null;
    }
  }

  void getUsername() {
    user.value = NavigationController.to.user.value;
    if (user.value.firstName != null ||
        user.value.firstName != "" ||
        user.value.lastName != null ||
        user.value.lastName != "") {
      name.value = "${user.value.firstName} ${user.value.lastName}";
    } else {
      name.value = user.value.username;
    }
  }
}
