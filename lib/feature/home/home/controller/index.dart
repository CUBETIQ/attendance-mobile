import 'dart:async';
import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/model/attendance_chart_model.dart';
import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/model/summary_attendance_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/extensions/string.dart';
import 'package:attendance_app/feature/home/home/model/check_in_model.dart';
import 'package:attendance_app/feature/home/home/model/check_out_model.dart';
import 'package:attendance_app/feature/home/home/model/update_user_status_model.dart';
import 'package:attendance_app/feature/home/home/service/index.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/profile/profile/controller/index.dart';
import 'package:attendance_app/utils/attendance_util.dart';
import 'package:attendance_app/utils/types_helper/attendance_method.dart';
import 'package:attendance_app/utils/types_helper/role.dart';
import 'package:attendance_app/utils/time_util.dart';
import 'package:attendance_app/utils/types_helper/user_status.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  static HomeController get to => Get.find();
  late TabController? tabController;
  RxString getUserRole = "".obs;
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
  RxList<AttendanceModel> staffAttendanceList = <AttendanceModel>[].obs;
  RxList<PositionModel> positionList = <PositionModel>[].obs;
  var isLoadingList = false.obs;
  var isLoadingStaffAttendance = false.obs;
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
  RxList<String> attendanceType = <String>[
    "Check In",
    "Check Out",
  ].obs;
  RxList<String> status = <String>[
    UserStatus.active,
    UserStatus.doNotDisturb,
    UserStatus.idle,
  ].obs;
  RxString selectedStatus = UserStatus.active.obs;
  RxString selectedAttendanceType = "Check In".obs;
  Rxn<String> name = Rxn<String>(null);
  var isLoadingSummary = false.obs;
  Rxn<int> totalAttendance = Rxn<int>(null);
  Rxn<int> totalAbsent = Rxn<int>(null);
  Rxn<int> totalLeave = Rxn<int>(null);
  RxList<AttendanceChartModel> attendanceChart = <AttendanceChartModel>[].obs;
  Rx<int> totalChartPresent = 0.obs;
  Rx<int> totalChartAbsent = 0.obs;
  Rx<int> totalChartLeave = 0.obs;
  RxDouble presentPercentage = 0.0.obs;
  RxDouble absentPercentage = 0.0.obs;
  RxDouble onLeavePercentage = 0.0.obs;
  RxInt totalStaff = 0.obs;
  Rx<DateTime> selectDate = DateTime.now().obs;
  RxBool haveNoData = false.obs;
  RxList<String> tabs = <String>[].obs;
  RxList<UserModel> staffs = <UserModel>[].obs;
  RxInt totalStaffs = 0.obs;
  RxInt totalCheckInLate = 0.obs;
  RxInt totalCheckInOnTime = 0.obs;
  RxInt totalCheckInEarly = 0.obs;
  RxInt totalCheckOutLate = 0.obs;
  RxInt totalCheckOutOnTime = 0.obs;
  RxInt totalCheckOutEarly = 0.obs;
  RxBool isCheckIn = true.obs;
  RxDouble latePercentage = 0.0.obs;
  RxDouble onTimePercentage = 0.0.obs;
  RxDouble earlyPercentage = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    initDate();
    initAnimation();
    initTabWithRole();
    getAttendance();
    checkBreakTime();
    getUsername();
    getSummarizeAttendance();
    checkTime();
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

  Future<void> onTapDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: date,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      selectDate.value = picked;
      startOfDay.value = DateTimeUtil().getStartOfDayInMilisecond(picked);
      endOfDay.value = DateTimeUtil().getEndOfDayInMilisecond(picked);
      getDashboardChart();
      getAllStaffAttendance();
    }
  }

  void initTabWithRole() {
    if (NavigationController.to.getUserRole.value == Role.staff) {
      tabController = null;
    } else {
      tabs.value = ["Dashboard", "Attendance"];
      tabController = TabController(length: 2, vsync: this);
      initAdminFunction();
    }
  }

  Future<void> initAdminFunction() async {
    getAllPositions();
    await getDashboardChart();
    await getAllStaffs();
    getAllStaffAttendance();
  }

  Future<void> getAllPositions() async {
    try {
      positionList.value = await HomeService().getAllPosition(
          organizationId: NavigationController.to.organization.value.id ?? "");
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getAllStaffs() async {
    try {
      staffs.value = await HomeService().getAllStaffs(
          organizationId: NavigationController.to.organization.value.id ?? "");
      totalStaffs.value = staffs.length;
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> checkIn() async {
    DateTime now = await checkTime();
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
          checkInEarly: GetMinute().checkEarlyMinute(startHour.value, now),
          checkInLate: GetMinute().checkLateMinute(startHour.value, now),
          checkInLocation: location,
        );
        AttendanceModel checkIn = await HomeService().checkIn(input);
        checkInTime.value = DateFormatter().formatTime(
          DateTime.fromMillisecondsSinceEpoch(checkIn.checkInDateTime!),
        );
        getAttendance();
        isCheckedIn.value = true;
        await getSummarizeAttendance();
        if (Get.isRegistered<ProfileController>()) {
          ProfileController.to.getSummarizeAttendance();
        }
        getCheckInBottomSheet(Get.context!, image: SvgAssets.working);
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response?.data["message"]);
        rethrow;
      }
    }
  }

  Future<void> checkOut() async {
    controller.forward();
    DateTime now = await checkTime();
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
        checkOutEarly: GetMinute().checkEarlyMinute(endHour.value, now),
        checkOutLate: GetMinute().checkLateMinute(endHour.value, now),
        checkOutLocation: location,
      );
      AttendanceModel checkOut = await HomeService().checkOut(input);
      checkOutTime.value = DateFormatter().formatTime(
        DateTime.fromMillisecondsSinceEpoch(checkOut.checkOutDateTime!),
      );
      isCheckedIn.value = false;
      getAttendance();
      getCheckOutBottomSheet(Get.context!, image: SvgAssets.leaving);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> updateUserStatus(String status) async {
    try {
      UpdateUserStatusModel input = UpdateUserStatusModel(
        status: status,
        lastUpdatedAt: DateTime.now().millisecondsSinceEpoch,
      );
      await HomeService().updateUserStatus(input);
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

  Future<void> getAllStaffAttendance() async {
    isLoadingStaffAttendance.value = true;
    try {
      staffAttendanceList.value = await HomeService().getAllStaffAttendance(
        startDate: startOfDay.value,
        endDate: endOfDay.value,
        organizationId: NavigationController.to.organization.value.id ?? "",
      );
    } on DioException catch (e) {
      isLoadingStaffAttendance.value = false;
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoadingStaffAttendance.value = false;
    }
  }

  Future<void> getDashboardChart() async {
    clearChartData();
    try {
      attendanceChart.value = await HomeService().getAttendanceChart(
        startDate: startOfDay.value,
        endDate: endOfDay.value,
        organizationId: NavigationController.to.organization.value.id ?? "",
      );
      if (attendanceChart.isNotEmpty) {
        totalStaff.value = attendanceChart.first.totalStaff ?? 0;
        haveNoData.value = false;
        for (var element in attendanceChart) {
          totalChartPresent.value += element.totalAttendance ?? 0;
          totalChartAbsent.value += element.totalAbsent ?? 0;
          totalChartLeave.value += element.totalLeave ?? 0;
          totalCheckInLate.value += element.totalCheckinLate ?? 0;
          totalCheckInOnTime.value += element.totalCheckinOnTime ?? 0;
          totalCheckInEarly.value += element.totalCheckinEarly ?? 0;
          totalCheckOutLate.value += element.totalCheckoutLate ?? 0;
          totalCheckOutOnTime.value += element.totalCheckoutOnTime ?? 0;
          totalCheckOutEarly.value += element.totalCheckoutEarly ?? 0;
        }
        presentPercentage.value =
            (totalChartPresent.value / totalStaff.value) * 100;
        absentPercentage.value =
            (totalChartAbsent.value / totalStaff.value) * 100;
        onLeavePercentage.value =
            (totalChartLeave.value / totalStaff.value) * 100;
        latePercentage.value =
            ((totalCheckInLate.value / totalStaff.value) * 100) / 100;
        onTimePercentage.value =
            ((totalCheckInOnTime.value / totalStaff.value) * 100) / 100;
        earlyPercentage.value =
            ((totalCheckInEarly.value / totalStaff.value) * 100) / 100;
      } else {
        haveNoData.value = true;
      }
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<DateTime> checkTime() async {
    DateTime myTime;
    DateTime ntpTime;
    DateTime result;

    /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
    myTime = DateTime.now().toLocal();

    /// Or get NTP offset (in milliseconds) and add it yourself
    final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
    ntpTime = myTime.add(Duration(milliseconds: offset));

    if (myTime.difference(ntpTime).inMinutes > 1) {
      result = ntpTime;
    } else {
      result = myTime;
    }
    return result;
  }

  void clearChartData() {
    totalCheckInEarly.value = 0;
    totalCheckInOnTime.value = 0;
    totalCheckInLate.value = 0;
    totalCheckOutEarly.value = 0;
    totalCheckOutOnTime.value = 0;
    totalCheckOutLate.value = 0;
    latePercentage.value = 0;
    onTimePercentage.value = 0;
    earlyPercentage.value = 0;
    totalChartPresent.value = 0;
    totalChartAbsent.value = 0;
    totalChartLeave.value = 0;
    presentPercentage.value = 0;
    absentPercentage.value = 0;
    onLeavePercentage.value = 0;
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

  void onSelectStatus(String? value) {
    if (selectedStatus.value != value) {
      selectedStatus.value = value!;
      updateUserStatus(selectedStatus.value);
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
        NavigationController.to.startBreakTime.split(":").first;
    final endBreakHour = NavigationController.to.endBreakTime.split(":").first;
    if (time >= int.parse(startBreakHour) && time < int.parse(endBreakHour)) {
      isBreakTime.value = true;
      breakTimeTitle.value = "Ongoing";
    } else if (time >= int.parse(endBreakHour)) {
      isBreakTime.value = true;
      breakTimeTitle.value = "Finished";
    } else {
      isBreakTime.value = false;
      breakTimeTitle.value = null;
    }
  }

  void getUsername() {
    user.value = NavigationController.to.user.value;
    selectedStatus.value =
        NavigationController.to.userStatus.value.status ?? UserStatus.active;
    if (user.value.firstName != null ||
        user.value.firstName != "" ||
        user.value.lastName != null ||
        user.value.lastName != "") {
      name.value = "${user.value.firstName} ${user.value.lastName}";
    } else {
      name.value = user.value.username;
    }
  }

  void onChanged(String? value) {
    if (selectedAttendanceType.value != value) {
      selectedAttendanceType.value = value!;
      isCheckIn.value = !isCheckIn.value;
      if (attendanceChart.isNotEmpty) {
        if (selectedAttendanceType.value == "Check In") {
          latePercentage.value =
              ((totalCheckInLate.value / totalStaff.value) * 100) / 100;
          onTimePercentage.value =
              ((totalCheckInOnTime.value / totalStaff.value) * 100) / 100;
          earlyPercentage.value =
              ((totalCheckInEarly.value / totalStaff.value) * 100) / 100;
        } else {
          latePercentage.value =
              ((totalCheckOutLate.value / totalStaffs.value) * 100) / 100;
          onTimePercentage.value =
              ((totalCheckOutOnTime.value / totalStaffs.value) * 100) / 100;
          earlyPercentage.value =
              ((totalCheckOutEarly.value / totalStaffs.value) * 100) / 100;
        }
      }
    }
  }
}
