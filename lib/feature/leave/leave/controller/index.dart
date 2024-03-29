import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/date_picker/month_picker.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/leave/leave/service/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/leave.dart';
import 'package:timesync/types/state.dart';

class LeaveController extends GetxController {
  static LeaveController get to => Get.find();
  final leaves = <LeaveModel>[].obs;
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
  final leaveType = <String>[
    LeaveFilter.all,
    LeaveFilter.awaiting,
    LeaveFilter.approved,
    LeaveFilter.declined,
  ].obs;
  final selectedLeaveType = LeaveFilter.all.obs;
  final backupLeave = <LeaveModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initFunction();
  }

  Future<void> initFunction() async {
    initDate();
    await getUserLeave();
  }

  Future<void> onRefresh() async {
    await getUserLeave();
  }

  Future<void> getUserLeave() async {
    isLoading.value = true;
    totalLeave.value = 0;
    try {
      backupLeave.value = await LeaveService().getUserLeave(
        startDate: startDate.value,
        endDate: endDate.value,
      );
      leaves.value = backupLeave.value;
      calculateLeave();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
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
    Get.toNamed(Routes.LEAVE_DETAIL, arguments: {
      "leave": leaves[index],
      "hasButtons": false,
    });
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
    }
  }

  void calculateLeave() {
    totalLeave.value = backupLeave.length;
    totalPendingLeave.value = backupLeave
        .where((element) => element.status == LeaveStatus.pending)
        .length;
    totalApprovedLeave.value = backupLeave
        .where((element) => element.status == LeaveStatus.approved)
        .length;
    totalDeclinedLeave.value = backupLeave.where((element) {
      return element.status == LeaveStatus.rejected ||
          element.status == LeaveStatus.cancelled;
    }).length;

    percentagePendingLeave.value = totalPendingLeave.value == 0
        ? 0
        : totalPendingLeave.value / totalLeave.value * 100;
    percentageApprovedLeave.value = totalApprovedLeave.value == 0
        ? 0
        : totalApprovedLeave.value / totalLeave.value * 100;
    percentageDeclinedLeave.value = totalDeclinedLeave.value == 0
        ? 0
        : totalDeclinedLeave.value / totalLeave.value * 100;
  }

  void onChangedLeaveType(String? value) {
    if (selectedLeaveType.value != value) {
      selectedLeaveType.value = value!;
      if (value == LeaveFilter.all) {
        leaves.value = backupLeave.value;
      } else if (selectedLeaveType.value == LeaveFilter.approved) {
        leaves.value = backupLeave.value
            .where((element) => element.status == LeaveStatus.approved)
            .toList();
      } else if (selectedLeaveType.value == LeaveFilter.declined) {
        leaves.value = backupLeave.value
            .where((element) =>
                element.status == LeaveStatus.rejected ||
                element.status == LeaveStatus.cancelled)
            .toList();
      } else {
        leaves.value = backupLeave.value
            .where((element) => element.status == LeaveStatus.pending)
            .toList();
      }
    }
  }
}
