import 'package:timesync/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync/core/database/isar/entities/local_storage.dart';
import 'package:timesync/core/database/isar/model/local_storage_model.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/core/model/department_model.dart';
import 'package:timesync/core/model/organization_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/model/user_status_model.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/splash/service/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static SplashController get to => Get.find();
  final user = UserModel().obs;
  final position = PositionModel().obs;
  final double frameRate = 70;
  final String title = 'timesync';
  late AnimationController controller;
  late Animation<double> animation;
  final localDataService = LocalStorageController.getInstance();
  final localData = LocalStorage().obs;
  final department = DepartmentModel().obs;
  final userStatus = UserStatusModel().obs;
  final organization = OrganizationModel().obs;
  LocalStorageModel? localStorageData = LocalStorageModel();

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
      await getUserStatus();
      if (user.value.positionId != null && user.value.positionId != "") {
        await getPosition();
      }
      if (user.value.departmentId != null && user.value.departmentId != "") {
        await getDepartment();
      }
    }
    initRoute();
  }

  void initRoute() {
    if (localData.value.isActivated != true) {
      Get.offNamed(Routes.ACTIVATION);
      return;
    } else if (localData.value.accessToken != null) {
      Get.offNamed(Routes.NAVIGATION, arguments: {
        "user": user.value,
        "position": position.value,
        "department": department.value,
        "organization": organization.value,
        "userStatus": userStatus.value,
      });
      return;
    } else if (localData.value.isFirstTime == false) {
      Get.offNamed(Routes.LOGIN);
      return;
    }
    Get.offNamed(Routes.ONBOARD);
  }

  Future<void> getUserStatus() async {
    try {
      userStatus.value = await SplashService().getUserStatus();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> fetchMe() async {
    try {
      user.value = await SplashService().fetchMe();
      localStorageData = LocalStorageModel(
        userId: user.value.id,
        organizationId: user.value.organizationId,
      );
      await IsarService().saveLocalData(input: localStorageData);
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
      if (data?.organizationId == null &&
          data?.isActivated == true &&
          data?.accessToken == null) {
        Get.offNamed(Routes.LOGIN);
        return;
      }
      organization.value =
          await SplashService().validateOrganization(id: data!.organizationId!);
      await initLocalDb();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }
}
