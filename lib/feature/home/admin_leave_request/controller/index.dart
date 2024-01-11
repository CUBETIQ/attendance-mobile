import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminLeaveRequestController extends GetxController {
  static AdminLeaveRequestController get to => Get.find();
  Rx<DateTime> selectDate = DateTime.now().obs;
  Rxn<int> startDate = Rxn<int>(null);
  Rxn<int> endDate = Rxn<int>(null);
  DateTime date = DateTime.now();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> onTapDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: date,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      selectDate.value = picked;
    }
  }
}
