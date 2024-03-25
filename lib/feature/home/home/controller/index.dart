import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/model/attendance_chart_model.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/summary_attendance_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/date_picker/month_picker.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/home/home/model/check_in_model.dart';
import 'package:timesync/feature/home/home/model/check_out_model.dart';
import 'package:timesync/feature/home/home/model/update_user_status_model.dart';
import 'package:timesync/feature/home/home/service/index.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/profile/profile/controller/index.dart';
import 'package:timesync/feature/scan_qr/service/index.dart';
import 'package:timesync/notification/notification_schdule.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/attendance_method.dart';
import 'package:timesync/types/role.dart';
import 'package:timesync/types/user_status.dart';
import 'package:timesync/utils/attendance_util.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/double_util.dart';
import 'package:timesync/utils/validator.dart';
import 'package:uni_links/uni_links.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  static HomeController get to => Get.find();
  late TabController? tabController;
  final getUserRole = "".obs;
  final date = DateTime.now();
  final isCheckedIn = false.obs;
  final checkInTime = Rxn<String>(null);
  final checkOutTime = Rxn<String>(null);
  final dateInMiliSecond = Rxn<int>(null);
  final startOfDay = Rxn<int>(null);
  final endOfDay = Rxn<int>(null);
  final startOfMonth = 0.obs;
  final endOfMonth = 0.obs;
  final attendanceList = <AttendanceModel>[].obs;
  final staffAttendanceList = <AttendanceModel>[].obs;
  final positionList = <PositionModel>[].obs;
  final isLoadingList = false.obs;
  final isLoadingStaffAttendance = false.obs;
  final startHour = "8:00".obs;
  final endHour = "17:00".obs;
  final totalHour = Rxn<String>(null);
  final currentDate = "".obs;
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  final isInRange = false.obs;
  final user = UserModel().obs;
  final summaryAttendance = <SummaryAttendanceModel>[].obs;
  final attendanceType = <String>[
    "Check in",
    "Check out",
  ].obs;
  final status = <String>[
    UserStatus.active,
    UserStatus.doNotDisturb,
    UserStatus.idle,
  ].obs;
  final selectedStatus = UserStatus.active.obs;
  final selectedAttendanceType = "Check in".obs;
  final name = Rxn<String>(null);
  final isLoadingSummary = false.obs;
  final totalAttendance = Rxn<int>(null);
  final totalAbsent = Rxn<int>(null);
  final totalLeave = Rxn<int>(null);
  final totalLateDuration = Rxn<int>(null);
  final attendanceChart = <AttendanceChartModel>[].obs;
  final totalChartPresent = 0.obs;
  final totalChartAbsent = 0.obs;
  final totalChartLeave = 0.obs;
  final presentPercentage = 0.0.obs;
  final absentPercentage = 0.0.obs;
  final onLeavePercentage = 0.0.obs;
  final totalStaff = 0.obs;
  final selectDate = DateTime.now().obs;
  final selectMonth = DateTime.now().obs;
  final haveNoData = false.obs;
  final tabs = <String>[].obs;
  final staffs = <UserModel>[].obs;
  final totalCheckInLate = 0.obs;
  final totalCheckInOnTime = 0.obs;
  final totalCheckInEarly = 0.obs;
  final totalCheckOutLate = 0.obs;
  final totalCheckOutOnTime = 0.obs;
  final totalCheckOutEarly = 0.obs;
  final isCheckIn = true.obs;
  final latePercentage = 0.0.obs;
  final onTimePercentage = 0.0.obs;
  final earlyPercentage = 0.0.obs;
  final isStartBreakTime = true.obs;
  final isEndBreakTime = true.obs;
  final startBreakTime = Rxn<int>(null);
  final endBreakTime = Rxn<int>(null);
  final totalWorkHour = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    initDate();
    initAnimation();
    initTabWithRole();
    getUsername();
    await getAttendance();
    getSummarizeAttendance();
    checkTime();
    listenToDeepLink();
  }

  void onRefresh() {
    NavigationController.to.getUserLocation();
    getAttendance();
    getSummarizeAttendance();
  }

  void listenToDeepLink() {
    uriLinkStream.listen(
      (Uri? uri) async {
        if (uri != null) {
          QRService().initDeepLink();
        }
      },
    );

    if (!Validator.isValNull(QRService().deepLinkUrl.value)) {
      QRService()
          .initDeepLink()
          .whenComplete(() => QRService().deepLinkUrl.value = null);
    }
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
      startOfDay.value = DateUtil.getStartOfDayInMilisecond(picked);
      endOfDay.value = DateUtil.getEndOfDayInMilisecond(picked);
      getDashboardChart();
      getAllStaffAttendance();
    }
  }

  Future<void> onTapMonth() async {
    final DateTime? picked = await monthPicker(
      context: Get.context!,
      initialDate: selectMonth.value,
    );
    if (picked != null) {
      selectMonth.value = picked;
      startOfMonth.value = DateUtil.getStartOfMonthInMilliseconds(picked) ?? 0;
      endOfMonth.value = DateUtil.getEndOfMonthInMilliseconds(picked) ?? 0;
      getSummarizeAttendance();
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
    await getAllPositions();
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
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  // This function is used to cancel the notification reminder when user check in/out early
  void cancelNotificationReminder({bool? checkOut}) {
    if (NavigationController.to.organization.value.configs == null) return;
    String? time;
    int? hour;
    int? min;

    if (checkOut == true) {
      time = NavigationController.to.organization.value.configs?.endHour;
    } else {
      time = NavigationController.to.organization.value.configs?.startHour;
    }

    if (time != null) {
      final split = time.split(":");
      hour = int.parse(split[0]);
      min = int.parse(split[1]);

      if (checkOut == true) {
        if (DateTime.now().hour <= hour &&
            DateTime.now().minute <= min &&
            // !Validator.isValNull(checkOutTime.value)
            isCheckedIn.value == false) {
          NotificationSchedule.cancelCheckOutReminder();

          // Init check out reminder for next day
          NotificationSchedule.checkOutReminder(
              toNextDay: true,
              time:
                  NavigationController.to.organization.value.configs?.endHour);
        }
      } else {
        if (DateTime.now().hour <= hour &&
            DateTime.now().minute <= min &&
            // !Validator.isValNull(checkInTime.value)
            isCheckedIn.value == true) {
          NotificationSchedule.cancelCheckInReminder();

          // Init check in reminder for next day
          NotificationSchedule.checkInReminder(
              toNextDay: true,
              time: NavigationController
                  .to.organization.value.configs?.startHour);
        }
      }
    }
  }

  Future<void> onTapBreak() async {
    getConfirmBottomSheet(
      Get.context!,
      title: "Break Time",
      description: attendanceList.last.breakTime?.start == null
          ? "Are you sure that you want to take a break?"
          : "Are you sure that you want to end your break?",
      image: SvgAssets.option,
      onTapConfirm: () async {
        Get.back();
        try {
          final date = await checkTime();
          final result =
              await HomeService().breakTime(date.millisecondsSinceEpoch);
          if (result.breakTime?.start != null &&
              result.breakTime?.end == null) {
            isStartBreakTime.value = false;
            startBreakTime.value = result.breakTime?.start;
          } else {
            endBreakTime.value = result.breakTime?.end;
            isStartBreakTime.value = false;
            isEndBreakTime.value = false;
          }
          await getAttendance(validateBreakTime: false, noLoading: true);
        } on DioException catch (e) {
          showErrorSnackBar("Error", e.response?.data["message"]);
          rethrow;
        }
      },
    );
  }

  void clearBreakTime() {
    isStartBreakTime.value = true;
    isEndBreakTime.value = true;
    startBreakTime.value = null;
    endBreakTime.value = null;
  }

  Future<void> checkIn() async {
    clearBreakTime();
    final checkLocation = await checkUserLocation();
    if (checkLocation == false) {
      return;
    }
    getConfirmCheckInOutBottomSheet(
      confirmCheckIn: AppConfig.confirmCheckIn.value,
      onTapConfirm: () async {
        DateTime now = await checkTime();
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
                CheckInStatusValidator.getStatus(startHour.value, now),
            checkInEarly: GetMinute.checkEarlyMinute(startHour.value, now),
            checkInLate: GetMinute.checkLateMinute(startHour.value, now),
            checkInLocation: location,
          );
          AttendanceModel checkIn = await HomeService().checkIn(input);
          checkInTime.value = DateUtil.formatTime(
            DateTime.fromMillisecondsSinceEpoch(checkIn.checkInDateTime!),
          );
          await getAttendance(noLoading: true);
          isCheckedIn.value = true;
          await getSummarizeAttendance();
          if (Get.isRegistered<ProfileController>()) {
            ProfileController.to.getSummarizeAttendance();
          }
          // workingHourDuration();
          cancelNotificationReminder();
          getCheckInBottomSheet(Get.context!, image: SvgAssets.working);
        } on DioException catch (e) {
          if (e.response?.data["message"]
                  .toString()
                  .contains("Please check out") ==
              true) {
            getForgetCheckOutBottomSheet(
              Get.context!,
              isDismissible: true,
              image: SvgAssets.leaving,
              onTap: () async {
                Get.back();
                await checkOut();
              },
            );
          } else {
            showErrorSnackBar("Error", e.response?.data["message"]);
          }
          rethrow;
        }
      },
    );
  }

  Future<void> checkOut() async {
    final checkLocation = await checkUserLocation();
    if (checkLocation == false) {
      return;
    }
    getConfirmCheckInOutBottomSheet(
      isCheckOut: true,
      confirmCheckIn: AppConfig.confirmCheckIn.value,
      onTapConfirm: () async {
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
            checkOutStatus:
                CheckOutStatusValidator().getStatus(endHour.value, now),
            checkOutEarly: GetMinute.checkEarlyMinute(endHour.value, now),
            checkOutLate: GetMinute.checkLateMinute(endHour.value, now),
            checkOutLocation: location,
          );
          AttendanceModel checkOut = await HomeService().checkOut(input);
          checkOutTime.value = DateUtil.formatTime(
            DateTime.fromMillisecondsSinceEpoch(checkOut.checkOutDateTime!),
          );
          isCheckedIn.value = false;
          await getAttendance(noLoading: true);
          cancelNotificationReminder(checkOut: true);
          getCheckOutBottomSheet(Get.context!, image: SvgAssets.leaving);
        } on DioException catch (e) {
          showErrorSnackBar("Error", e.response?.data["message"]);
          rethrow;
        }
      },
    );
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

  Future<void> getAttendance({bool? validateBreakTime, bool? noLoading}) async {
    totalWorkHour.value = 0;
    isLoadingList.value = noLoading == true ? false : true;
    try {
      attendanceList.value = await HomeService().getAttendance(
        startDate: startOfDay.value,
        endDate: endOfDay.value,
      );
      if (attendanceList.isNotEmpty) {
        if (attendanceList.last.checkOutDateTime != null) {
          totalHour.value = DateUtil.formatMinutes(
            attendanceList.last.duration!,
          );
        }
        checkInTime.value = DateUtil.formatTime(
          DateTime.fromMillisecondsSinceEpoch(
            attendanceList.last.checkInDateTime!,
          ),
        );

        if (validateBreakTime != false) {
          if (attendanceList.last.breakTime?.start != null &&
              attendanceList.last.breakTime?.end == null) {
            isStartBreakTime.value = false;
          } else if (attendanceList.last.breakTime?.start != null &&
              attendanceList.last.breakTime?.end != null) {
            isStartBreakTime.value = false;
            isEndBreakTime.value = false;
          }
        }

        if (attendanceList.last.checkOutDateTime == null) {
          isCheckedIn.value = true;
        } else {
          checkOutTime.value = DateUtil.formatTime(
            DateTime.fromMillisecondsSinceEpoch(
              attendanceList.last.checkOutDateTime!,
            ),
          );
          isCheckedIn.value = false;
        }
        for (var element in attendanceList) {
          totalWorkHour.value += element.duration ?? 0;
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

        totalChartPresent.value = attendanceChart.first.totalAttendance ?? 0;
        totalChartAbsent.value = attendanceChart.first.totalAbsent ?? 0;
        totalChartLeave.value = attendanceChart.first.totalLeave ?? 0;
        totalCheckInLate.value = attendanceChart.first.totalCheckinLate ?? 0;
        totalCheckInOnTime.value =
            attendanceChart.first.totalCheckinOnTime ?? 0;
        totalCheckInEarly.value = attendanceChart.first.totalCheckinEarly ?? 0;
        totalCheckOutLate.value = attendanceChart.first.totalCheckoutLate ?? 0;
        totalCheckOutOnTime.value =
            attendanceChart.first.totalCheckoutOnTime ?? 0;
        totalCheckOutEarly.value =
            attendanceChart.first.totalCheckoutEarly ?? 0;

        // Percentage for attendance chart
        presentPercentage.value = DoubleUtil.caculatePercentage(
            totalChartPresent.value, totalStaff.value);
        absentPercentage.value = DoubleUtil.caculatePercentage(
            totalChartAbsent.value, totalStaff.value);
        onLeavePercentage.value = DoubleUtil.caculatePercentage(
            totalChartLeave.value, totalStaff.value);

        // Percentage for check in and check out
        latePercentage.value = DoubleUtil.caculatePercentageForProgress(
            totalCheckInLate.value, totalStaff.value);
        onTimePercentage.value = DoubleUtil.caculatePercentageForProgress(
            totalCheckInOnTime.value, totalStaff.value);
        earlyPercentage.value = DoubleUtil.caculatePercentageForProgress(
            totalCheckInEarly.value, totalStaff.value);
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

    try {
      /// Or get NTP offset (in milliseconds) and add it yourself
      final int offset =
          await NTP.getNtpOffset(localTime: DateTime.now().toLocal());
      ntpTime = myTime.add(Duration(milliseconds: offset));
      result = ntpTime;
    } catch (e) {
      result = DateTime.now();
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
    totalLateDuration.value = 0;
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
        totalLateDuration.value =
            ((totalLateDuration.value ?? 0) + (element.totalLateDuration ?? 0));
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

  void onTapAttendanceStatistic(String status) {
    Get.toNamed(
      Routes.ATTENDANCE_STATISTIC,
      arguments: {
        "title": selectedAttendanceType.value,
        "staffs": staffs,
        "attendance": selectedAttendanceType.value == "Check in"
            ? staffAttendanceList
                .where((element) => element.checkInStatus == status)
                .toList()
            : staffAttendanceList
                .where((element) => element.checkOutStatus == status)
                .toList(),
      },
    );
  }

  Future<void> initDate() async {
    final DateTime date = await checkTime();
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
    currentDate.value = DateFormat('EEEE, dd MMMM yyyy').format(date);
  }

  Future<bool> checkUserLocation() async {
    if (NavigationController.to.userLocation.value == null) {
      await NavigationController.to.getUserLocation();
      if (NavigationController.to.userLocation.value != null) {
        return true;
      } else {
        return false;
      }
    }
    return true;
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
          latePercentage.value = DoubleUtil.caculatePercentageForProgress(
              totalCheckInLate.value, totalStaff.value);
          onTimePercentage.value = DoubleUtil.caculatePercentageForProgress(
              totalCheckInOnTime.value, totalStaff.value);
          earlyPercentage.value = DoubleUtil.caculatePercentageForProgress(
              totalCheckInEarly.value, totalStaff.value);
        } else {
          latePercentage.value = DoubleUtil.caculatePercentageForProgress(
              totalCheckOutLate.value, totalStaff.value);
          onTimePercentage.value = DoubleUtil.caculatePercentageForProgress(
              totalCheckOutOnTime.value, totalStaff.value);
          earlyPercentage.value = DoubleUtil.caculatePercentageForProgress(
              totalCheckOutEarly.value, totalStaff.value);
        }
      }
    }
  }
}
