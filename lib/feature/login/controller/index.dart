import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  String title = 'login';
  final usernameFormKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }
}
