import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextFieldFormController extends GetxController {
  late GlobalKey<FormState> formKey;

  bool get isValid => formKey.currentState?.validate() ?? false;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
  }

  static MyTextFieldFormController get to =>
      Get.find<MyTextFieldFormController>();

  static MyTextFieldFormController findController(String label) {
    return Get.put(MyTextFieldFormController(), tag: label);
  }
}
