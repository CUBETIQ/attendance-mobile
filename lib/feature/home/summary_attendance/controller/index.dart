import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/home/summary_attendance/service/index.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/types/role.dart';

class SummaryAttendanceController extends GetxController
    with GetTickerProviderStateMixin {
  static SummaryAttendanceController get to => Get.find();
  final staffAttendanceList = <AttendanceModel>[].obs;
  final staffs = <UserModel>[].obs;
  final leaves = <LeaveModel>[].obs;
  final startOfTheDay = Rxn<int>(null);
  final endOfTheDay = Rxn<int>(null);
  final getNonAbsentUser = <UserModel>[].obs;
  final absentUser = <UserModel>[].obs;
  final isLoading = false.obs;
  final tabs = [
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
      final leaveList = await SummaryAttendanceService().getAllLeave(
        startDate: startOfTheDay.value,
        endDate: endOfTheDay.value,
        organizationId: NavigationController.to.organization.value.id ?? "",
      );
      leaves.value = removeDuplicateLeave(leaveList);
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
    List<UserModel> updatedStaffs = Get.arguments["staffs"];
    staffs.value.addAll(
        updatedStaffs.where((element) => element.role != Role.superadmin));
    final List<AttendanceModel> allAttendances = Get.arguments["attendances"];
    staffAttendanceList.value = removeDuplicateAttendances(allAttendances);
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

  List<AttendanceModel> removeDuplicateAttendances(
      List<AttendanceModel> attendances) {
    Set<String> userId = <String>{};
    List<AttendanceModel> uniqueAttendances = [];

    for (AttendanceModel attendance in attendances) {
      if (userId.add(attendance.userId!)) {
        uniqueAttendances.add(attendance);
      }
    }

    return uniqueAttendances;
  }

  List<LeaveModel> removeDuplicateLeave(List<LeaveModel> leaves) {
    Set<String> userId = <String>{};
    List<LeaveModel> uniqueLeaves = [];

    for (LeaveModel leave in leaves) {
      if (userId.add(leave.userId!)) {
        // userId is not present in the set, so this is a unique entry
        uniqueLeaves.add(leave);
      }
    }

    return uniqueLeaves;
  }
}
