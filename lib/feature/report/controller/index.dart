import 'package:timesync360/core/model/admin_attendance_report_model.dart';
import 'package:timesync360/core/model/admin_leave_report_model.dart';
import 'package:timesync360/core/model/admin_task_report_model.dart';
import 'package:timesync360/core/model/attendance_model.dart';
import 'package:timesync360/core/model/leave_model.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/feature/report/service/index.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:timesync360/types/leave_status.dart';
import 'package:timesync360/types/role.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController with GetTickerProviderStateMixin {
  static ReportController get to => Get.find();
  final staffReports = <AdminAttendanceReportModel>[].obs;
  final staffLeaveReports = <AdminLeaveReportModel>[].obs;
  final staffTaskReports = <AdminTaskReportModel>[].obs;
  final startDate = Rxn<int>();
  final endDate = Rxn<int>();
  final selectedDate = DateTime.now().obs;
  final isLoading = false.obs;
  final calendarFocusedDay = DateTime.now().obs;
  final calendarStartOfTheMonth = Rxn<int>();
  final calendarEndOfTheMonth = Rxn<int>();
  final calendarStartOfTheDay = Rxn<int>();
  final calendarEndOfTheDay = Rxn<int>();
  final attendanceList = <AttendanceModel>[].obs;
  final attendanceResult = <AttendanceModel>[].obs;
  final tabs = <String>[].obs;
  late TabController? tabController;
  final events = <DateTime, List>{}.obs;
  final leaveResult = <LeaveModel>[].obs;
  final leaves = <LeaveModel>[].obs;
  final savedSelectedDate = DateTime.now().obs;
  final reportTab = ["Attendance", "Leave"];

  @override
  void onInit() {
    super.onInit();
    initDate();
    initAdminFunction();
    initFunction();
  }

  Future<void> initFunction() async {
    await getAttendance();
    await getLeave();
    onDaySelected(DateTime.now(), DateTime.now());
  }

  Future<void> onRefresh() async {
    initAdminFunction();
  }

  Future<void> onRefreshStaffReport() async {
    await getAttendance();
    getLeave();
  }

  Future<void> initAdminFunction() async {
    if (NavigationController.to.getUserRole.value != Role.staff) {
      tabs.value = ["Employee", "Report"];
      tabController = TabController(length: 2, vsync: this);
      await getStaffAttendanceReport();
      await getStaffLeaveReport();
      await getStaffTaskReport();
    }
  }

  Future<void> getStaffAttendanceReport() async {
    isLoading.value = true;
    try {
      staffReports.value = await ReportService().getStaffAttendanceReport(
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

  Future<void> getStaffLeaveReport() async {
    isLoading.value = true;
    try {
      staffLeaveReports.value = await ReportService().getStaffLeaveReport(
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

  Future<void> getStaffTaskReport() async {
    isLoading.value = true;
    try {
      staffTaskReports.value = await ReportService().getStaffTaskReport(
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

  List<Object?> eventLoader(DateTime day) {
    return events.value[day] ?? [];
  }

  Future<void> onPageChanged(DateTime date) async {
    if (DateTime(date.year, date.month) !=
        DateTime(DateTime.now().year, DateTime.now().month)) {
      calendarStartOfTheMonth.value =
          DateTimeUtil().getStartOfMonthInMilliseconds(date);
      calendarEndOfTheMonth.value =
          DateTimeUtil().getEndOfMonthInMilliseconds(date);
      await getAttendance();
      await getLeave();
      onDaySelected(date, date);
    } else {
      calendarFocusedDay.value = DateTime.now();
      calendarStartOfTheMonth.value =
          DateTimeUtil().getStartOfMonthInMilliseconds(DateTime.now());
      calendarEndOfTheMonth.value =
          DateTimeUtil().getEndOfMonthInMilliseconds(DateTime.now());
      await getAttendance();
      await getLeave();
      onDaySelected(DateTime.now(), DateTime.now());
    }
  }

  Future<void> getLeave() async {
    try {
      leaveResult.value = await ReportService().getUserLeave(
        startDate: calendarStartOfTheMonth.value,
        endDate: calendarEndOfTheMonth.value,
      );
      leaves.value = leaveResult
          .where(
            (element) =>
                (element.from ?? 0) >=
                    (DateTimeUtil().getStartOfDayInMilisecond(
                            savedSelectedDate.value) ??
                        0) &&
                (element.from ?? 0) <=
                    (DateTimeUtil()
                            .getEndOfDayInMilisecond(savedSelectedDate.value) ??
                        0) &&
                element.status == LeaveStatus.approved,
          )
          .toList();
      for (var i = 0; i < leaveResult.length; i++) {
        if (leaveResult[i].from != null &&
            leaveResult[i].status == LeaveStatus.approved) {
          DateTime date = DateTime.utc(
            DateTime.fromMillisecondsSinceEpoch(leaveResult[i].from ?? 0).year,
            DateTime.fromMillisecondsSinceEpoch(leaveResult[i].from ?? 0).month,
            DateTime.fromMillisecondsSinceEpoch(leaveResult[i].from ?? 0).day,
          );
          if (events.value.containsKey(date)) {
            // If the date is already in events.value, add the index to the existing list
            events.value[date]?.add("Leave");
          } else {
            // If the date is not in events.value, create a new entry with a list containing the index
            events.value[date] = ["Leave"];
          }
        }
      }
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getAttendance({DateTime? date}) async {
    events.value = {};
    try {
      attendanceResult.value = await ReportService().getAttendance(
        startDate: calendarStartOfTheMonth.value,
        endDate: calendarEndOfTheMonth.value,
      );
      attendanceList.value = attendanceResult
          .where((element) =>
              (element.checkInDateTime ?? 0) >=
                  (DateTimeUtil()
                          .getStartOfDayInMilisecond(savedSelectedDate.value) ??
                      0) &&
              (element.checkInDateTime ?? 0) <=
                  (DateTimeUtil()
                          .getEndOfDayInMilisecond(savedSelectedDate.value) ??
                      0))
          .toList();
      for (var i = 0; i < attendanceResult.length; i++) {
        if (attendanceResult[i].checkInDateTime != null) {
          DateTime date = DateTime.utc(
            DateTime.fromMillisecondsSinceEpoch(
                    attendanceResult[i].checkInDateTime ?? 0)
                .year,
            DateTime.fromMillisecondsSinceEpoch(
                    attendanceResult[i].checkInDateTime ?? 0)
                .month,
            DateTime.fromMillisecondsSinceEpoch(
                    attendanceResult[i].checkInDateTime ?? 0)
                .day,
          );
          if (events.value.containsKey(date)) {
            // If the date is already in events.value, add the index to the existing list
            events.value[date]?.add("Present");
          } else {
            // If the date is not in events.value, create a new entry with a list containing the index
            events.value[date] = ["Present"];
          }
        }
      }
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
      await getStaffAttendanceReport();
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    attendanceList.value = [];
    calendarFocusedDay.value = selectedDay;
    savedSelectedDate.value = selectedDay;
    attendanceList.value = attendanceResult
        .where((element) =>
            (element.checkInDateTime ?? 0) >=
                (DateTimeUtil().getStartOfDayInMilisecond(selectedDay) ?? 0) &&
            (element.checkInDateTime ?? 0) <=
                (DateTimeUtil().getEndOfDayInMilisecond(selectedDay) ?? 0))
        .toList();
    leaves.value = leaveResult
        .where(
          (element) =>
              (element.from ?? 0) >=
                  (DateTimeUtil().getStartOfDayInMilisecond(selectedDay) ??
                      0) &&
              (element.from ?? 0) <=
                  (DateTimeUtil().getEndOfDayInMilisecond(selectedDay) ?? 0) &&
              element.status == LeaveStatus.approved,
        )
        .toList();
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
