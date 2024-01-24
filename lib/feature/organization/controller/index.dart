import 'package:attendance_app/core/model/organization_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/organization/service/index.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class OrganizationController extends GetxController {
  static OrganizationController get to => Get.find();
  Rx<OrganizationModel> organization = OrganizationModel().obs;
  RxList<UserModel> staffs = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getOrganization();
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
}
