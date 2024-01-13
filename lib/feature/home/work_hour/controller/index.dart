import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkHourController extends GetxController {
  static WorkHourController get to => Get.find();
  RxList<UserModel> staffs = <UserModel>[].obs;
  RxList<AttendanceModel> attendances = <AttendanceModel>[].obs;
  RxList<PositionModel> positions = <PositionModel>[].obs;
  Rx<DateTime> selectDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  void getArgument() {
    final args = Get.arguments;
    staffs.value = args["staffs"];
    attendances.value = args["attendances"];
    positions.value = args["positions"];
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
    }
  }
}
