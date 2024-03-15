import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync/core/database/isar/entities/local_storage.dart';
import 'package:timesync/core/database/isar/model/local_storage_model.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/core/model/department_model.dart';
import 'package:timesync/core/model/organization_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/model/user_status_model.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/qr/service/index.dart';
import 'package:timesync/feature/splash/service/index.dart';
import 'package:timesync/notification/notification_topic.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/role.dart';
import 'package:timesync/utils/logger.dart';
import 'package:uni_links/uni_links.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static SplashController get to => Get.find();
  final user = UserModel().obs;
  final position = PositionModel().obs;
  final double frameRate = 70;
  final String title = 'TimeSync';
  late AnimationController controller;
  late Animation<double> animation;
  final localDataService = LocalStorageController.getInstance();
  final localData = LocalStorage().obs;
  final department = DepartmentModel().obs;
  final userStatus = UserStatusModel().obs;
  final organization = OrganizationModel().obs;
  LocalStorageModel? localStorageData = LocalStorageModel();
  final isAdmin = false.obs;

  @override
  void onInit() {
    super.onInit();
    validateOrganization();
    initDeepLink();
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

  Future<void> initDeepLink() async {
    try {
      QRService().deepLinkUrl.value = await getInitialLink();
    } catch (e) {
      Logs.e('[SplashController.initDeepLInk] Error', error: e);
    }
  }

  Future<void> initLocalDb() async {
    if (localData.value.accessToken != null &&
        localData.value.accessToken != "") {
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
    } else if (localData.value.accessToken != null &&
        localData.value.accessToken != "") {
      handleNotification(isAdmin.value);
      Get.offNamed(
        Routes.NAVIGATION,
        arguments: {
          "user": user.value,
          "position": position.value,
          "department": department.value,
          "organization": organization.value,
          "userStatus": userStatus.value,
        },
      );
      return;
    } else if (localData.value.isFirstTime == false) {
      Get.offNamed(
        Routes.LOGIN,
        arguments: {
          "organization": organization.value,
        },
      );
      return;
    }
    Get.offNamed(Routes.ONBOARD);
  }

  void handleNotification(bool isAdmin) {
    if (AppConfig.getLocalData?.isEnableNotification == true) {
      NotificationTopic.subscribe([
        NotificationTopic.getUserTypeTopic(isAdmin: isAdmin, id: user.value.id),
      ]);
    }
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
        userRole: user.value.role,
      );
      if (user.value.role == Role.admin) {
        isAdmin.value = true;
      }
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
      Get.offNamed(Routes.ACTIVATION);
      await IsarService().clearLocalData(
        deleteToken: true,
        unactivate: true,
        deleteOrganization: true,
      );
      rethrow;
    }
  }

  void onResetApp() {
    getConfirmBottomSheet(
      Get.context!,
      image: SvgAssets.empty,
      title: "Reset App",
      description: "Are you sure you want to reset the app?",
      onTapConfirm: () async {
        await IsarService().clearDataBase();
        NotificationTopic.unsubscribeAll();
        Restart.restartApp();
      },
    );
  }
}
