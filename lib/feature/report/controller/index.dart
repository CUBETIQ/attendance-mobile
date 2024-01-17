import 'package:attendance_app/core/model/admin_attendance_report_model.dart';
import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/widgets/console/console.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/report/service/index.dart';
import 'package:attendance_app/utils/time_util.dart';
import 'package:attendance_app/utils/types_helper/role.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController with GetTickerProviderStateMixin {
  static ReportController get to => Get.find();
  RxList<AdminReportModel> staffReports = <AdminReportModel>[].obs;
  Rxn<int> startDate = Rxn<int>();
  Rxn<int> endDate = Rxn<int>();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool isLoading = false.obs;
  Rx<DateTime> calendarFocusedDay = DateTime.now().obs;
  Rxn<int> calendarStartOfTheMonth = Rxn<int>();
  Rxn<int> calendarEndOfTheMonth = Rxn<int>();
  Rxn<int> calendarStartOfTheDay = Rxn<int>();
  Rxn<int> calendarEndOfTheDay = Rxn<int>();
  RxList<AttendanceModel> attendanceList = <AttendanceModel>[].obs;
  List<AttendanceModel> result = <AttendanceModel>[];
  RxList<String> tabs = <String>[].obs;
  late TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    initDate();
    initAdminFunction();
    getAttendance();
  }

  Future<void> onRefresh() async {
    initAdminFunction();
  }

  Future<void> initAdminFunction() async {
    if (NavigationController.to.getUserRole.value == Role.admin) {
      tabs.value = ["Employee", "Report"];
      tabController = TabController(length: 2, vsync: this);
      await getStaffReport();
    }
  }

  Future<void> getStaffReport() async {
    isLoading.value = true;
    try {
      staffReports.value = await ReportService().getStaffReport(
        organizationId: NavigationController.to.user.value.organizationId ?? "",
        startDate: startDate.value,
        endDate: endDate.value,
      );
    } on Exception catch (e) {
      showErrorSnackBar("Error", e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAttendance() async {
    try {
      result = await ReportService().getAttendance(
        startDate: calendarStartOfTheMonth.value,
        endDate: calendarEndOfTheMonth.value,
      );
      attendanceList.value = result
          .where((element) =>
              (element.checkInDateTime ?? 0) >= (startDate.value ?? 0) &&
              (element.checkOutDateTime ?? 0) <= (endDate.value ?? 0))
          .toList();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
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
      await getStaffReport();
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    attendanceList.value = [];
    calendarFocusedDay.value = selectedDay;
    attendanceList.value = result
        .where((element) =>
            (element.checkInDateTime ?? 0) >=
                (DateTimeUtil().getStartOfDayInMilisecond(selectedDay) ?? 0) &&
            (element.checkInDateTime ?? 0) <=
                (DateTimeUtil().getEndOfDayInMilisecond(selectedDay) ?? 0))
        .toList();
    Console.log([
      selectedDay,
      DateTimeUtil().getStartOfDayInMilisecond(selectedDay),
      DateTimeUtil().getEndOfDayInMilisecond(selectedDay)
    ], attendanceList.value);
  }

  void initDate() {
    startDate.value =
        DateTimeUtil().getStartOfDayInMilisecond(selectedDate.value);
    endDate.value = DateTimeUtil().getEndOfDayInMilisecond(selectedDate.value);
    calendarStartOfTheMonth.value =
        DateTimeUtil().getStartOfMonthInMilliseconds(calendarFocusedDay.value);
    calendarEndOfTheMonth.value =
        DateTimeUtil().getEndOfMonthInMilliseconds(calendarFocusedDay.value);
  }
}
