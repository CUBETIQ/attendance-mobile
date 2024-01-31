import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/model/organization_model.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/feature/organization/organiziation/service/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class OrganizationController extends GetxController {
  static OrganizationController get to => Get.find();
  Rx<OrganizationModel> organization = OrganizationModel().obs;
  RxList<UserModel> staffs = <UserModel>[].obs;
  RxList<PositionModel> positions = <PositionModel>[].obs;
  RxList<DepartmentModel> departments = <DepartmentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getOrganization();
    getAllPositions();
    getAllDepartments();
    getAllStaffs();
  }

  Future<void> getOrganization() async {
    try {
      organization.value = await OrganizationService().getOrganization(
        id: NavigationController.to.organization.value.id!,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getAllStaffs() async {
    try {
      staffs.value = await OrganizationService().getAllStaffs(
        organizationId: NavigationController.to.organization.value.id ?? "",
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getAllPositions() async {
    try {
      positions.value = await OrganizationService().getAllPosition(
        organizationId: NavigationController.to.organization.value.id ?? "",
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getAllDepartments() async {
    try {
      departments.value = await OrganizationService().getDepartment(
        organizationId: NavigationController.to.organization.value.id ?? "",
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> onTabEdit() async {
    final result = await Get.toNamed(Routes.EDIT_ORGANIZATION,
        arguments: organization.value);
    if (result != null) {
      getOrganization();
    }
  }
}
