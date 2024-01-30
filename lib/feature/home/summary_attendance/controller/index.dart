import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/model/leave_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/home/summary_attendance/service/index.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryAttendanceController extends GetxController
    with GetTickerProviderStateMixin {
  static SummaryAttendanceController get to => Get.find();
  RxList<AttendanceModel> staffAttendanceList = <AttendanceModel>[].obs;
  RxList<UserModel> staffs = <UserModel>[].obs;
  RxList<LeaveModel> leaves = <LeaveModel>[].obs;
  Rxn<int> startOfTheDay = Rxn<int>(null);
  Rxn<int> endOfTheDay = Rxn<int>(null);
  RxList<UserModel> getNonAbsentUser = <UserModel>[].obs;
  RxList<UserModel> absentUser = <UserModel>[].obs;
  RxBool isLoading = false.obs;
  RxList<String> tabs = [
    "Present",
    "Leave",
    "Absent",
  ].obs;
  late TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    getArgument();
    getAllLeave();
  }

  Future<void> getAllLeave() async {
    isLoading.value = true;
    try {
      leaves.value = await SummaryAttendanceService().getAllLeave(
        startDate: startOfTheDay.value,
        endDate: endOfTheDay.value,
        organizationId: NavigationController.to.organization.value.id ?? "",
      );
      getAbsentUser();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAbsentUser() async {
    try {
      absentUser.value = staffs
          .where((element) => !getNonAbsentUser.contains(element))
          .toList();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void getArgument() {
    staffs.value = Get.arguments["staffs"];
    staffAttendanceList.value = Get.arguments["attendances"];
    startOfTheDay.value = Get.arguments["startDate"];
    endOfTheDay.value = Get.arguments["endDate"];
  }

  // Function to get attendance details for a staff member
  UserModel getStaffForAttendance(AttendanceModel atttendance) {
    final staff =
        staffs.firstWhere((element) => element.id == atttendance.userId);
    getNonAbsentUser.value.add(staff);
    return staff;
  }

  // Function to get leave details for a staff member
  UserModel getStaffForLeave(LeaveModel leave) {
    final staff = staffs.firstWhere((element) => element.id == leave.userId);
    getNonAbsentUser.value.add(staff);
    return staff;
  }
}
