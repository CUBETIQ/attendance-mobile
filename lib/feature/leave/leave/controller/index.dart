import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/model/summary_leave_model.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/date_picker/month_picker.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/home/admin_leave_request/model/change_leave_status.dart';
import 'package:timesync/feature/leave/leave/service/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/leave_status.dart';
import 'package:timesync/types/state.dart';

class LeaveController extends GetxController {
  static LeaveController get to => Get.find();
  final leaves = <LeaveModel>[].obs;
  final summarizeLeaves = <SummaryLeaveModel>[].obs;
  var isLoading = false.obs;
  final startDate = Rxn<int>(null);
  final endDate = Rxn<int>(null);
  final totalLeave = 0.obs;
  final totalPendingLeave = 0.obs;
  final totalApprovedLeave = 0.obs;
  final totalDeclinedLeave = 0.obs;
  final percentagePendingLeave = 0.0.obs;
  final percentageApprovedLeave = 0.0.obs;
  final percentageDeclinedLeave = 0.0.obs;
  final selectDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    initFunction();
  }

  Future<void> initFunction() async {
    initDate();
    await getUserLeave();
    getUserSummarizeLeave();
  }

  Future<void> onRefresh() async {
    await getUserLeave();
    getUserSummarizeLeave();
  }

  Future<void> getUserLeave() async {
    isLoading.value = true;
    totalLeave.value = 0; 
    try {
      leaves.value = await LeaveService().getUserLeave(
        startDate: startDate.value,
        endDate: endDate.value,
      );
      totalLeave.value = leaves.length;
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getUserSummarizeLeave() async {
    clearData();
    try {
      summarizeLeaves.value = await LeaveService().getUserLeavSummarize(
        startDate: startDate.value,
        endDate: endDate.value,
      );

      if (summarizeLeaves.isNotEmpty && totalLeave.value != 0) {
        for (var element in summarizeLeaves) {
          totalPendingLeave.value += element.totalPendingLeave!;
          totalApprovedLeave.value += element.totalApprovedLeave!;
          totalDeclinedLeave.value += element.totalRejectedLeave!;
        }
        percentageApprovedLeave.value =
            (totalApprovedLeave.value / totalLeave.value * 100) / 100;
        percentagePendingLeave.value =
            (totalPendingLeave.value / totalLeave.value * 100) / 100;
        percentageDeclinedLeave.value =
            (totalDeclinedLeave.value / totalLeave.value * 100) / 100;
      }
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> deleteLeave(String id) async {
    try {
      getConfirmBottomSheet(
        Get.context!,
        title: "Delete Leave Request",
        titleColor: Theme.of(Get.context!).colorScheme.error,
        description: "Are you sure that you want to delete this Leave Request?",
        onTapConfirm: () async {
          await LeaveService().deleteLeave(id);
          await getUserLeave();
          getUserSummarizeLeave();
          Get.back();
        },
        image: SvgAssets.delete,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void onTapLeave(LeaveModel leave) {
    getEditAndDeleteBottomSheet(
      Get.context!,
      image: SvgAssets.option,
      onTapEdit: () {
        Get.back();
        Get.toNamed(
          Routes.ADD_LEAVE,
          arguments: {
            "state": AppState.edit,
            "leave": leave,
          },
        );
      },
      onTapDelete: () {
        Get.back();
        deleteLeave(leave.id!);
      },
    );
  }

  void initDate() {
    DateTime now = DateTime.now();
    startDate.value = DateTime(now.year, now.month, 1).millisecondsSinceEpoch;
    endDate.value = DateTime(now.year, now.month + 1, 0).millisecondsSinceEpoch;
  }

  void clearData() {
    totalPendingLeave.value = 0;
    totalApprovedLeave.value = 0;
    totalDeclinedLeave.value = 0;
    percentagePendingLeave.value = 0.0;
    percentageApprovedLeave.value = 0.0;
    percentageDeclinedLeave.value = 0.0;
  }

  void onTapView(int index) {
    Get.toNamed(Routes.LEAVE_DETAIL, arguments: leaves[index]);
  }

  void onTapCancel(LeaveModel? leave) {
    ChangeLeaveStatusModel data = ChangeLeaveStatusModel(
      status: LeaveStatus.cancelled,
      updatedDate: leave?.from ?? DateTime.now().millisecondsSinceEpoch,
    );
    try {
      getConfirmBottomSheet(
        Get.context!,
        title: "Cancel Leave Request",
        titleColor: Theme.of(Get.context!).colorScheme.error,
        description: "Are you sure that you want to cancel this Leave Request?",
        onTapConfirm: () async {
          await LeaveService().cancelLeave(input: data, id: leave?.id ?? "");
          await getUserLeave();
          getUserSummarizeLeave();
          Get.back();
        },
        image: SvgAssets.cancel,
      );
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
      await getUserLeave();
      getUserSummarizeLeave();
    }
  }
}
