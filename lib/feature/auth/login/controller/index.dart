import 'package:attendance_app/core/database/isar/service/isar_service.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:attendance_app/feature/auth/login/model/index.dart';
import 'package:attendance_app/feature/auth/login/service/index.dart';
import 'package:attendance_app/feature/splash/service/index.dart';
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

  Future<void> login() async {
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
            accessToken: accessToken.first, refreshToken: accessToken.last);
        await fetchMe();
        Get.offNamed(Routes.NAVIGATION, arguments: user.value);
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
    await IsarService().saveLocalData(
        isRememberMe: isRememberMe.value, username: usernameController.text);
  }

  Future<void> fetchMe() async {
    try {
      user.value = await SplashService().fetchMe();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }
}
