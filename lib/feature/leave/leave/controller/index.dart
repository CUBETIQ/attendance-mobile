import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/model/leave_model.dart';
import 'package:attendance_app/core/model/summary_leave_model.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/leave/leave/service/index.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:attendance_app/utils/types_helper/state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveController extends GetxController {
  static LeaveController get to => Get.find();
  RxList<LeaveModel> leave = <LeaveModel>[].obs;
  RxList<SummaryLeaveModel> summarizeLeaves = <SummaryLeaveModel>[].obs;
  var isLoading = false.obs;
  Rxn<int> startDate = Rxn<int>();
  Rxn<int> endDate = Rxn<int>();
  Rx<int> totalLeave = 0.obs;
  Rx<int> totalPendingLeave = 0.obs;
  Rx<int> totalApprovedLeave = 0.obs;
  Rx<int> totalDeclinedLeave = 0.obs;
  RxDouble percentagePendingLeave = 0.0.obs;
  RxDouble percentageApprovedLeave = 0.0.obs;
  RxDouble percentageDeclinedLeave = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    initFunction();
  }

  Future<void> initFunction() async {
    // initDate();
    await getOwnLeave();
    getOwnSummarizeLeave();
  }

  void onRefresh() {
    initFunction();
  }

  Future<void> getOwnLeave() async {
    isLoading.value = true;
    totalLeave.value = 0;
    try {
      leave.value = await LeaveService().getOwnLeave(
        startDate: startDate.value,
        endDate: endDate.value,
      );
      totalLeave.value = leave.length;
    } on DioException catch (e) {
      isLoading.value = false;
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getOwnSummarizeLeave() async {
    clearData();
    try {
      summarizeLeaves.value = await LeaveService().getUserLeavSummarize(
        startDate: startDate.value,
        endDate: endDate.value,
      );
      if (summarizeLeaves.isNotEmpty) {
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
          await getOwnLeave();
          getOwnSummarizeLeave();
          Get.back();
        },
        image: delete,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void onTapLeave(LeaveModel leave) {
    getOptionBottomSheet(
      Get.context!,
      image: option,
      onTapEdit: () {
        Get.back();
        Get.toNamed(
          Routes.ADD_LEAVE,
          arguments: {
            "state": AppState.Edit,
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
    Get.toNamed(Routes.LEAVE_DETAIL, arguments: leave[index]);
  }

  void onTapCancel(String id) {
    try {
      getConfirmBottomSheet(
        Get.context!,
        title: "Cancel Leave Request",
        titleColor: Theme.of(Get.context!).colorScheme.error,
        description: "Are you sure that you want to cancel this Leave Request?",
        onTapConfirm: () async {
          await LeaveService().deleteLeave(id);
          await getOwnLeave();
          getOwnSummarizeLeave();
          Get.back();
        },
        image: cancel,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }
}
