import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/model/department_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/employee/employee/service/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffController extends GetxController {
  static StaffController get to => Get.find();
  final staffsBackUp = <UserModel>[].obs;
  final staffs = <UserModel>[].obs;
  final positions = <PositionModel>[].obs;
  final departments = <DepartmentModel>[].obs;
  final organizationId = "".obs;
  final isLoading = false.obs;
  final searchController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    organizationId.value = NavigationController.to.organization.value.id ?? "";
    onInitStaff();
  }

  Future<void> onInitStaff() async {
    await getAllPositions();
    await getAllDepartments();
    getAllStaffs();
  }

  Future<void> onRefresh() async {
    await getAllPositions();
    await getAllDepartments();
    getAllStaffs();
  }

  Future<void> getAllStaffs() async {
    try {
      staffsBackUp.value = await StaffService()
          .getAllStaffs(organizationId: organizationId.value);
      staffs.value = staffsBackUp.value;
    } on DioException catch (e) {
      isLoading.value = false;
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllPositions() async {
    isLoading.value = true;
    try {
      positions.value = await StaffService()
          .getAllPosition(organizationId: organizationId.value);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getAllDepartments() async {
    try {
      departments.value = await StaffService()
          .getDepartment(organizationId: organizationId.value);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> deleteStaff(String id) async {
    try {
      getConfirmBottomSheet(
        Get.context!,
        title: "Delete Staff",
        description: "Are you sure to delete this staff?",
        onTapConfirm: () async {
          await StaffService().deleteStaff(id);
          getAllStaffs();
          Get.back();
        },
        image: SvgAssets.delete,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void onTapStaff(UserModel staff) {
    getOptionsBottomSheet(
      Get.context!,
      image: SvgAssets.option,
      onTapEdit: () {
        Get.toNamed(
          Routes.ADD_STAFF,
          arguments: {
            "state": AppState.edit,
            "positions": positions,
            "departments": departments,
            "staff": staff,
          },
        );
        Get.back();
      },
      onTapDelete: () {
        Get.back();
        deleteStaff(staff.id!);
      },
      onTapChangePassword: () {
        Get.back();
        Get.toNamed(
          Routes.CHANGE_PASSWORD,
          arguments: {"data": staff, "isStaff": true},
        );
      },
    );
  }

  void onTapViewDetail(
    UserModel staff,
    PositionModel position,
    DepartmentModel department,
  ) {
    Get.toNamed(
      Routes.STAFF_DETAIL,
      arguments: {
        "staff": staff,
        "position": position,
        "department": department,
      },
    );
  }

  void onTapAddStaff() {
    Get.toNamed(
      Routes.ADD_STAFF,
      arguments: {
        "state": AppState.create,
        "positions": positions,
        "departments": departments
      },
    );
  }

  void searchStaff(String value) {
    if (value.isEmpty) {
      staffs.value = staffsBackUp.value;
    } else {
      staffs.value = staffsBackUp.value.where((element) {
        return (element.username?.toLowerCase().contains(value.toLowerCase()) ??
                false) ||
            (element.firstName?.toLowerCase().contains(value.toLowerCase()) ??
                false) ||
            (element.lastName?.toLowerCase().contains(value.toLowerCase()) ??
                false);
      }).toList();
    }
  }

  void clearSearch() {
    if (searchController.text.isNotEmpty) {
      searchController.clear();
      staffs.value = staffsBackUp.value;
    }
  }
}
