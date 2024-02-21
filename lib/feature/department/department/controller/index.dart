import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/feature/department/department/service/index.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/types/state.dart';
import '../../../../routes/app_pages.dart';

class DepartmentController extends GetxController {
  static DepartmentController get to => Get.find();
  final departmentList = <DepartmentModel>[].obs;
  final departmentListBackUp = <DepartmentModel>[].obs;
  final isLoading = false.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAllDepartments();
  }

  Future<void> onRefresh() async {
    await getAllDepartments();
  }

  Future<void> getAllDepartments() async {
    isLoading.value = true;
    try {
      departmentListBackUp.value = await DepartmentService().getAllDepartment(
          organizationId: NavigationController.to.organization.value.id ?? "");
      departmentList.value = departmentListBackUp.value;
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDepartment(String id) async {
    try {
      await DepartmentService().deleteDepartment(id);
      departmentListBackUp.value.removeWhere((element) => element.id == id);
      departmentList.value = departmentListBackUp.value;
      departmentListBackUp.refresh();
      departmentList.refresh();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void searchDepartment(String value) {
    if (value.isEmpty) {
      departmentList.value = departmentListBackUp.value;
    } else {
      departmentList.value = departmentListBackUp.value.where((element) {
        return (element.name?.toLowerCase().contains(value.toLowerCase()) ??
            false);
      }).toList();
    }
  }

  void onTapAddDepartment() {
    Get.toNamed(Routes.ADD_DEPARTMENT, arguments: {"state": AppState.Create});
  }

  void clearSearch() {
    if (searchController.text.isNotEmpty) {
      searchController.clear();
      departmentList.value = departmentListBackUp.value;
    }
  }

  void onTapDepartmentDetail(DepartmentModel department) {
    Get.toNamed(Routes.DEPARTMENT_DETAIL, arguments: department);
  }

  void onTapDepartment(DepartmentModel department) {
    getEditAndDeleteBottomSheet(
      Get.context!,
      image: SvgAssets.option,
      onTapEdit: () {
        Get.toNamed(
          Routes.ADD_DEPARTMENT,
          arguments: {
            "state": AppState.Edit,
            "department": department,
          },
        );
        Get.back();
      },
      onTapDelete: () async {
        await deleteDepartment(department.id ?? "");
        Get.back();
      },
    );
  }
}
