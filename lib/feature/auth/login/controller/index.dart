import 'package:attendance_app/core/database/isar/service/isar_service.dart';
import 'package:attendance_app/core/network/dio_exception.dart';
import 'package:attendance_app/core/widgets/console/console.dart';
import 'package:attendance_app/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  String title = 'login';
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  Dio dioInstance = DioUtil.dio;
  RxBool isRememberMe = false.obs;

  Future<void> login() async {
    validate();
    if (MyTextFieldFormController.findController('Username').isValid &&
        MyTextFieldFormController.findController('Password').isValid) {
      try {
        var response = await dioInstance.post(
          Endpoints.instance.login,
          data: {
            "username": usernameController.text,
            "password": passwordController.text
          },
        );

        if (response.statusCode == 200) {
          await IsarService()
              .saveLocalData(accessToken: response.data["data"]["accessToken"]);
        } else {
          Console.log("Login failed", "Login failed");
        }
      } on DioException catch (e) {
        var errorMessage = DioExceptionHandler.fromDioError(e);
        Console.log(errorMessage, errorMessage);
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

  void forgetPassword() {
    Console.log("Forget password", "Forget password");
  }
}
