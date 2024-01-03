import 'package:attendance_app/core/database/isar/controller/local_storage_controller.dart';
import 'package:attendance_app/core/database/isar/service/isar_service.dart';
import 'package:attendance_app/core/model/department_model.dart';
import 'package:attendance_app/core/model/organization_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/widgets/debouncer/debouncer.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:attendance_app/feature/auth/login/model/index.dart';
import 'package:attendance_app/feature/auth/login/service/index.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/model/user_model.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  String title = 'login';
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  RxBool isRememberMe = false.obs;
  Rx<UserModel> user = UserModel().obs;
  Rx<PositionModel> position = PositionModel().obs;
  Rx<DepartmentModel> department = DepartmentModel().obs;
  Rxn<OrganizationModel> organization = Rxn<OrganizationModel>(null);
  final LocalStorageController localDataService =
      LocalStorageController.getInstance();
  final _debouncer = Debouncer(milliseconds: 500);

  void login() {
    _debouncer.run(() async {
      validate();
      if (MyTextFieldFormController.findController('Username').isValid &&
          MyTextFieldFormController.findController('Password').isValid) {
        try {
          LoginModel input = LoginModel(
            username: usernameController.text,
            password: passwordController.text,
          );
          var accessToken = await LoginService().login(input);
          await IsarService().saveLocalData(
            accessToken: accessToken.first,
            refreshToken: accessToken.last,
            organizationId: organization.value?.id,
          );
          await fetchMe();
          await getOrganization(user.value.organizationId!);
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
            });
          }
        } on DioException catch (e) {
          showErrorSnackBar("Error", e.response?.data["message"]);
          rethrow;
        }
      }
    });
  }

  void validate() {
    MyTextFieldFormController.findController('Username').isValid;
    MyTextFieldFormController.findController('Password').isValid;
  }

  Future<void> onCheck(bool? value) async {
    isRememberMe.value = value!;
    await IsarService().saveLocalData(
        isRememberMe: isRememberMe.value, username: usernameController.text);
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

  Future<void> getOrganization(String id) async {
    try {
      organization.value = await LoginService().getOrganization(id: id);
      if (organization.value != null) {
        await IsarService()
            .saveLocalData(organizationId: organization.value?.id);
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
}
