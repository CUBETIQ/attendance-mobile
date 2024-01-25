import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/model/department_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/employee/employee/service/index.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:attendance_app/utils/types_helper/state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffController extends GetxController {
  static StaffController get to => Get.find();
  RxList<UserModel> staffs = <UserModel>[].obs;
  RxList<PositionModel> positions = <PositionModel>[].obs;
  RxList<DepartmentModel> departments = <DepartmentModel>[].obs;
  RxString organizationId = "".obs;
  RxBool isLoading = false.obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

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
      staffs.value = await StaffService()
          .getAllStaffs(organizationId: organizationId.value);
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
            "state": AppState.Edit,
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
        "state": AppState.Create,
        "positions": positions,
        "departments": departments
      },
    );
  }
}
