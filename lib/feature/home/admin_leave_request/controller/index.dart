import 'package:timesync360/core/model/leave_model.dart';
import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/widgets/date_picker/month_picker.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/feature/home/admin_leave_request/model/change_leave_status.dart';
import 'package:timesync360/feature/home/admin_leave_request/service/index.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class AdminLeaveRequestController extends GetxController {
  static AdminLeaveRequestController get to => Get.find();
  final selectDate = DateTime.now().obs;
  final startDate = Rxn<int>(null);
  final endDate = Rxn<int>(null);
  final leaveList = <LeaveModel>[].obs;
  final staffList = <UserModel>[].obs;
  final isLoading = false.obs;

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
        updatedDate: leave?.from ?? DateTime.now().millisecondsSinceEpoch,
      );
      await AdminLeaveRequestService().changeLeaveStatus(
        input: data,
        id: leave?.id ?? "",
      );
      await getAllLeave(haveLoading: false);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> onTapDate(BuildContext context) async {
    final DateTime? picked = await monthPicker(
      context: context,
      initialDate: selectDate.value,
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
  }
}
