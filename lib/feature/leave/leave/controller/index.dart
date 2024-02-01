import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/model/leave_model.dart';
import 'package:timesync360/core/model/summary_leave_model.dart';
import 'package:timesync360/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/feature/leave/leave/service/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:timesync360/utils/types_helper/state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveController extends GetxController {
  static LeaveController get to => Get.find();
  RxList<LeaveModel> leaves = <LeaveModel>[].obs;
  RxList<SummaryLeaveModel> summarizeLeaves = <SummaryLeaveModel>[].obs;
  var isLoading = false.obs;
  Rxn<int> startDate = Rxn<int>(null);
  Rxn<int> endDate = Rxn<int>(null);
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
    await getUserLeave();
    getUserSummarizeLeave();
  }

  void onRefresh() {
    initFunction();
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
    Get.toNamed(Routes.LEAVE_DETAIL, arguments: leaves[index]);
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
}
