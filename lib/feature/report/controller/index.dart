import 'package:attendance_app/core/model/admin_attendance_report_model.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/report/service/index.dart';
import 'package:attendance_app/utils/time_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  static ReportController get to => Get.find();
  RxList<AdminReportModel> staffReports = <AdminReportModel>[].obs;
  Rxn<int> startDate = Rxn<int>();
  Rxn<int> endDate = Rxn<int>();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initDate();
    getStaffReport();
  }

  Future<void> onRefresh() async {
    await getStaffReport();
  }

  Future<void> getStaffReport() async {
    isLoading.value = true;
    try {
      final List<AdminReportModel> staffReport =
          await ReportService().getStaffReport(
        organizationId: NavigationController.to.user.value.organizationId ?? "",
        startDate: startDate.value,
        endDate: endDate.value,
      );
      staffReports.value = staffReport;
    } on Exception catch (e) {
      showErrorSnackBar("Error", e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onTapDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      selectedDate.value = picked;
      startDate.value = DateTimeUtil().getStartOfDayInMilisecond(picked);
      endDate.value = DateTimeUtil().getEndOfDayInMilisecond(picked);
    }
  }

  void initDate() {
    startDate.value =
        DateTimeUtil().getStartOfDayInMilisecond(selectedDate.value);
    endDate.value = DateTimeUtil().getEndOfDayInMilisecond(selectedDate.value);
  }
}
