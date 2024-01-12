import 'package:attendance_app/core/model/leave_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/console/console.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/home/admin_leave_request/model/change_leave_status.dart';
import 'package:attendance_app/feature/home/admin_leave_request/service/index.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class AdminLeaveRequestController extends GetxController {
  static AdminLeaveRequestController get to => Get.find();
  Rx<DateTime> selectDate = DateTime.now().obs;
  Rxn<int> startDate = Rxn<int>(null);
  Rxn<int> endDate = Rxn<int>(null);
  RxList<LeaveModel> leaveList = <LeaveModel>[].obs;
  RxList<UserModel> staffList = <UserModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    staffList.value = Get.arguments;
    initDate();
    getAllLeave();
  }

  Future<void> getAllLeave({bool haveLoading = true}) async {
    if (haveLoading) {
      isLoading.value = true;
    }
    try {
      leaveList.value = await AdminLeaveRequestService().getAllLeave(
        startDate: startDate.value,
        endDate: endDate.value,
        organizationId: NavigationController.to.organization.value.id ?? "",
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changeLeaveStatus({LeaveModel? leave, String? status}) async {
    try {
      ChangeLeaveStatusModel data = ChangeLeaveStatusModel(
        status: status,
        updateDate: leave?.from ?? DateTime.now().millisecondsSinceEpoch,
      );
      await AdminLeaveRequestService().changeLeaveStatus(
        input: data,
        id: leave?.id ?? "",
      );
      showSuccessSnackBar(
        "Success",
        "You have $status the leave request.",
      );
      await getAllLeave(haveLoading: false);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> onTapDate(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: selectDate.value,
      firstDate: DateTime(2019),
      lastDate: DateTime(2050),
      roundedCornersRadius: 24,
      animationMilliseconds: 0,
      dismissible: true,
    );
    if (picked != null) {
      selectDate.value = picked;
      startDate.value =
          DateTime(picked.year, picked.month, 1).millisecondsSinceEpoch;
      endDate.value =
          DateTime(picked.year, picked.month + 1, 0).millisecondsSinceEpoch;
      getAllLeave();
    }
  }

  Future<void> onRefresh() async {
    await getAllLeave();
  }

  void onTapView(int index) {
    Get.toNamed(Routes.LEAVE_DETAIL, arguments: leaveList[index]);
  }

  void initDate() {
    startDate.value = DateTime(DateTime.now().year, DateTime.now().month, 1)
        .millisecondsSinceEpoch;
    endDate.value = DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
        .millisecondsSinceEpoch;
    Console.log("Data", [startDate.value, endDate.value, staffList.value]);
  }
}
