import 'package:timesync/config/app_config.dart';
import 'package:timesync/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync/core/database/isar/model/local_storage_model.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/core/model/department_model.dart';
import 'package:timesync/core/model/organization_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_status_model.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync/feature/auth/login/model/index.dart';
import 'package:timesync/feature/auth/login/service/index.dart';
import 'package:timesync/notification/notification_topic.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/types/role.dart';
import '../../../../core/model/user_model.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  final String title = 'login';
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final isRememberMe = false.obs;
  final user = UserModel().obs;
  final position = PositionModel().obs;
  final department = DepartmentModel().obs;
  final organization = Rxn<OrganizationModel>(null);
  final localDataService = LocalStorageController.getInstance();
  final showPassword = true.obs;
  final userStatus = UserStatusModel().obs;
  LocalStorageModel? localStorageData = LocalStorageModel();
  final accessToken = Rxn<String>(null);
  final refreshToken = Rxn<String>(null);
  final isAdmin = false.obs;

  @override
  onInit() {
    super.onInit();
    initArguments();
    initRememberMe();
  }

  Future<void> login() async {
    validate();
    if (MyTextFieldFormController.findController('Username').isValid &&
        MyTextFieldFormController.findController('Password').isValid) {
      try {
        final storageData = await localDataService.get();
        LoginModel input = LoginModel(
          username: usernameController.text,
          password: passwordController.text,
        );
        final token = await LoginService().login(input);
        accessToken.value = token.first;
        refreshToken.value = token.last;
        await getOrganization(storageData?.organizationId ?? "");
        await fetchMe();
        await getUserStatus();
        await setRememberMe();
        if (organization.value == null) {
          Get.offNamed(Routes.ACTIVATION);
        } else {
          if (user.value.positionId != null && user.value.positionId != "") {
            await getPosition();
          }
          if (user.value.departmentId != null &&
              user.value.departmentId != "") {
            await getDepartment();
          }
          final isAdmin = user.value.role == Role.admin ? true : false;
          handleNotification(isAdmin);
          Get.offNamed(Routes.NAVIGATION, arguments: {
            "user": user.value,
            "position": position.value,
            "department": department.value,
            "organization": organization.value,
            "userStatus": userStatus.value,
          });
        }
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response?.data["message"]);
        rethrow;
      }
    }
  }

  Future<void> loginWithSSO() async {}

  void handleNotification(bool isAdmin) {
    if (AppConfig.getLocalData?.isEnableNotification == true) {
      NotificationTopic.subscribe([
        NotificationTopic.getUserTypeTopic(isAdmin: isAdmin, id: user.value.id),
      ]);
    }
  }

  void validate() {
    MyTextFieldFormController.findController('Username').isValid;
    MyTextFieldFormController.findController('Password').isValid;
  }

  void initRememberMe() {
    isRememberMe.value =
        AppConfig.getLocalData?.isRememberMe?.isNotEmpty == true ? true : false;
    if (AppConfig.getLocalData?.isRememberMe != null) {
      usernameController.text = AppConfig.getLocalData?.isRememberMe ?? "";
    }
  }

  Future<void> setRememberMe() async {
    if (isRememberMe.value == true) {
      if (usernameController.text.isNotEmpty) {
        localStorageData?.isRememberMe = usernameController.text;
      }
    } else {
      localStorageData?.isRememberMe = '';
    }
    await IsarService().saveLocalData(input: localStorageData);
  }

  Future<void> onCheck(bool? value) async {
    isRememberMe.value = value!;
  }

  Future<void> fetchMe() async {
    try {
      user.value = await LoginService().fetchMe();
      if (user.value.role == Role.admin) {
        isAdmin.value = true;
      }
      localStorageData = LocalStorageModel(
        userId: user.value.id,
        userRole: user.value.role,
      );
      await IsarService().saveLocalData(input: localStorageData);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getPosition() async {
    try {
      position.value = await LoginService().getPosition(user.value.positionId!);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getUserStatus() async {
    try {
      userStatus.value = await LoginService().getUserStatus();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getOrganization(String id) async {
    try {
      organization.value = await LoginService().getOrganization(id: id);
      if (organization.value != null) {
        localStorageData = LocalStorageModel(
          accessToken: accessToken.value,
          refreshToken: refreshToken.value,
          organizationId: organization.value?.id,
        );
        await IsarService().saveLocalData(input: localStorageData);
      }
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getDepartment() async {
    try {
      department.value =
          await LoginService().getDepartment(user.value.departmentId!);
    } on DioException catch (e) {
      Get.offNamed(Routes.ACTIVATION);
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void onTapShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void initArguments() {
    if (Get.arguments != null) {
      organization.value = Get.arguments["organization"];
    }
  }
}
