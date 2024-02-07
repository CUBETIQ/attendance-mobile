import 'package:timesync360/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync360/core/database/isar/model/lcoal_storage_model.dart';
import 'package:timesync360/core/database/isar/service/isar_service.dart';
import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/model/organization_model.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/model/user_status_model.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/feature/auth/login/model/index.dart';
import 'package:timesync360/feature/auth/login/service/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/model/user_model.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  final String title = 'login';
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final RxBool isRememberMe = false.obs;
  final Rx<UserModel> user = UserModel().obs;
  final Rx<PositionModel> position = PositionModel().obs;
  final Rx<DepartmentModel> department = DepartmentModel().obs;
  final Rxn<OrganizationModel> organization = Rxn<OrganizationModel>(null);
  final LocalStorageController localDataService =
      LocalStorageController.getInstance();
  RxBool showPassword = true.obs;
  Rx<UserStatusModel> userStatus = UserStatusModel().obs;
  LocalStorageModel? localStorageData = LocalStorageModel();
  Rxn<String> accessToken = Rxn<String>(null);
  Rxn<String> refreshToken = Rxn<String>(null);

  Future<void> login() async {
    validate();
    final storageData = await localDataService.get();
    if (MyTextFieldFormController.findController('Username').isValid &&
        MyTextFieldFormController.findController('Password').isValid) {
      try {
        LoginModel input = LoginModel(
          username: usernameController.text,
          password: passwordController.text,
        );
        var token = await LoginService().login(input);
        accessToken.value = token.first;
        refreshToken.value = token.last;
        await getOrganization(storageData?.organizationId ?? "");
        await fetchMe();
        await getUserStatus();
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

  void validate() {
    MyTextFieldFormController.findController('Username').isValid;
    MyTextFieldFormController.findController('Password').isValid;
  }

  Future<void> onCheck(bool? value) async {
    isRememberMe.value = value!;
    localStorageData?.isRememberMe = value;
    await IsarService().saveLocalData(
      input: localStorageData,
    );
  }

  Future<void> fetchMe() async {
    try {
      user.value = await LoginService().fetchMe();
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
      localStorageData?.organizationId = organization.value?.id;
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
}
