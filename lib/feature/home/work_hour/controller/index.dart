import 'package:timesync360/core/model/attendance_model.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/feature/home/work_hour/service/index.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkHourController extends GetxController {
  static WorkHourController get to => Get.find();
  final staffs = <UserModel>[].obs;
  final attendances = <AttendanceModel>[].obs;
  final positions = <PositionModel>[].obs;
  final selectDate = DateTime.now().obs;
  final startOfDay = Rxn<int>(null);
  final endOfDay = Rxn<int>(null);
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getArgument();
    initDate();
  }

  void getArgument() {
    final args = Get.arguments;
    staffs.value = args["staffs"];
    selectDate.value = args["date"];
    attendances.value = args["attendances"];
    positions.value = args["positions"];
  }

  Future<void> onRefresh() async {
    await getAllStaffAttendance();
  }

  Future<void> onTapDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectDate.value,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      selectDate.value = picked;
      initDate();
      await getAllStaffAttendance();
    }
  }

  Future<void> getAllStaffAttendance() async {
    isLoading.value = true;
    try {
      attendances.value = await WorkHourService().getAllStaffAttendance(
        startDate: startOfDay.value,
        endDate: endOfDay.value,
        organizationId: NavigationController.to.organization.value.id ?? "",
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Function to get position details for a staff member
  PositionModel getPositionForStaff(UserModel staff) {
    return positions.firstWhere(
      (element) => element.id == staff.positionId,
      orElse: () => PositionModel(),
    );
  }

  // Function to get attendance details for a staff member
  List<AttendanceModel> getAttendancesForStaff(UserModel staff) {
    return attendances.where((element) => element.userId == staff.id).toList();
  }

  void initDate() {
    startOfDay.value =
        DateTimeUtil().getStartOfDayInMilisecond(selectDate.value);
    endOfDay.value = DateTimeUtil().getEndOfDayInMilisecond(selectDate.value);
  }
}
