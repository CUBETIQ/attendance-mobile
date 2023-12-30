import 'package:attendance_app/core/database/isar/controller/local_storage_controller.dart';
import 'package:attendance_app/core/database/isar/entities/local_storage.dart';
import 'package:attendance_app/core/database/isar/service/isar_service.dart';
import 'package:attendance_app/core/model/department_model.dart';
import 'package:attendance_app/core/model/organization_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/splash/service/index.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static SplashController get to => Get.find();
  Rx<UserModel> user = UserModel().obs;
  Rx<PositionModel> position = PositionModel().obs;
  final double frameRate = 70;
  final String title = 'TimeSync360';
  late AnimationController controller;
  late Animation<double> animation;
  final LocalStorageController localDataService =
      LocalStorageController.getInstance();
  Rx<LocalStorage> localData = LocalStorage().obs;
  Rx<DepartmentModel> department = DepartmentModel().obs;
  Rx<OrganizationModel> organization = OrganizationModel().obs;

  @override
  void onInit() {
    super.onInit();
    validateOrganization();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
  }

  @override
  void onClose() {
    super.onClose();
    controller.dispose();
  }

  Future<void> initLocalDb() async {
    if (localData.value.accessToken != null) {
      await fetchMe();
      if (user.value.positionId != null && user.value.positionId != "") {
        await getPosition();
      }
      if (user.value.departmentId != null && user.value.departmentId != "") {
        await getDepartment();
      }
    }
  }

  Future<void> init() async {
    if (localData.value.isActivated != true) {
      Get.offNamed(Routes.ACTIVATION);
    } else if (localData.value.accessToken != null) {
      Get.offNamed(Routes.NAVIGATION, arguments: {
        "user": user.value,
        "position": position.value,
        "department": department.value,
        "organization": organization.value,
      });
    } else if (localData.value.isFirstTime == false) {
      Get.offNamed(Routes.LOGIN);
    } else {
      Get.offNamed(Routes.ONBOARD);
    }
  }

  Future<void> fetchMe() async {
    try {
      user.value = await SplashService().fetchMe();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getPosition() async {
    try {
      position.value =
          await SplashService().getPosition(user.value.positionId!);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getDepartment() async {
    try {
      department.value =
          await SplashService().getDepartment(user.value.departmentId!);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> validateOrganization() async {
    final data = await localDataService.get();
    localData.value = data ?? LocalStorage();
    await Future.delayed(const Duration(seconds: 2));
    try {
      if (data?.organizationId == null && data?.isActivated != true) {
        Get.offNamed(Routes.ACTIVATION);
        return;
      }
      if (data?.organizationId == null && data?.isActivated == true) {
        Get.offNamed(Routes.LOGIN);
        return;
      }
      organization.value =
          await SplashService().validateOrganization(id: data!.organizationId!);
      await IsarService().saveLocalData(organizationId: organization.value.id);
      await initLocalDb();
      init();
    } on DioException catch (e) {
      Get.offNamed(Routes.ACTIVATION);
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }
}
