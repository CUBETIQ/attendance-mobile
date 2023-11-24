import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextFieldFormController extends GetxController {
  late TextEditingController textFieldController;
  late GlobalKey<FormState> formKey;

  bool get isValid => formKey.currentState?.validate() ?? false;

  @override
  void onInit() {
    super.onInit();
    textFieldController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void onClose() {
    textFieldController.dispose();
    super.onClose();
  }

  static MyTextFieldFormController get to =>
      Get.find<MyTextFieldFormController>();

  static MyTextFieldFormController findController(String label) {
    return Get.put(MyTextFieldFormController(), tag: label);
  }
}
