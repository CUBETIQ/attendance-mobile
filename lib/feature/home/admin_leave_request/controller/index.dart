import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/date_picker/month_picker.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/home/admin_leave_request/model/change_leave_status.dart';
import 'package:timesync/feature/home/admin_leave_request/service/index.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/leave.dart';

class AdminLeaveRequestController extends GetxController {
  static AdminLeaveRequestController get to => Get.find();
  final selectDate = DateTime.now().obs;
  final startDate = Rxn<int>(null);
  final endDate = Rxn<int>(null);
  final leaveList = <LeaveModel>[].obs;
  final staffList = <UserModel>[].obs;
  final positions = <PositionModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    staffList.value = Get.arguments["staffs"];
    positions.value = Get.arguments["positions"];
    initDate();
    getAllLeave();
  }

  // Function to get position details for a staff member
  PositionModel getPositionForStaff(UserModel staff) {
    return positions.firstWhere(
      (element) => element.id == staff.positionId,
      orElse: () => PositionModel(),
    );
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
      leaveList.value
          .removeWhere((element) => element.status == LeaveStatus.cancelled);

      // Sorting leave by date and status
      leaveList.value.sort((a, b) {
        return (b.createdAt ?? DateTime.now())
            .compareTo(a.createdAt ?? DateTime.now());
      });

      int compareStatusOrder(String? statusA, String? statusB) {
        int statusOrder(String? status) {
          switch (status) {
            case LeaveStatus.pending:
              return 0;
            case LeaveStatus.approved:
              return 1;
            case LeaveStatus.rejected:
              return 2;
            default:
              return 3;
          }
        }

        return statusOrder(statusA ?? '').compareTo(statusOrder(statusB ?? ''));
      }

      leaveList.sort((a, b) {
        int priorityComparison = compareStatusOrder(a.status, b.status);
        if (priorityComparison != 0) {
          return priorityComparison;
        } else {
          DateTime dateA = a.createdAt ?? DateTime.now();
          DateTime dateB = b.createdAt ?? DateTime.now();
          return dateB.compareTo(dateA);
        }
      });
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
      Get.back();
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
    Get.toNamed(Routes.LEAVE_DETAIL, arguments: {
      "leave": leaveList[index],
      "hasButtons":
          leaveList[index].status == LeaveStatus.pending ? true : false,
    });
  }

  void initDate() {
    startDate.value = DateTime(DateTime.now().year, DateTime.now().month, 1)
        .millisecondsSinceEpoch;
    endDate.value = DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
        .millisecondsSinceEpoch;
  }
}
