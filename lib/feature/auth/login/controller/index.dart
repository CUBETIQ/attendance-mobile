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
          Console.log(response.data, response.data["data"]["accessToken"]);
        } else {
          Console.log("Login failed", "hello");
        }
      } on DioException catch (e) {
        var errorMessage = DioExceptionHandler.fromDioError(e);
        Console.log(errorMessage, errorMessage);
      }
    }
  }

  Future<void> loginWithGoogle() async {
    Console.log("Login with google", "hello");
  }

  Future<void> loginWithApple() async {
    Console.log("Login with apple", "hello");
  }

  void validate() {
    MyTextFieldFormController.findController('Username').isValid;
    MyTextFieldFormController.findController('Password').isValid;
  }
}
