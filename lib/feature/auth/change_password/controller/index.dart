import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync/feature/auth/change_password/model/change_password_model.dart';
import 'package:timesync/feature/auth/change_password/service/index.dart';

class ChangePasswordController extends GetxController {
  final user = UserModel().obs;
  final isChangeStaffPass = false.obs;
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final hideOldPassword = true.obs;
  final hideNewPassword = true.obs;
  final validator = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  void getArgument() {
    user.value = Get.arguments["data"];
    isChangeStaffPass.value = Get.arguments["isStaff"];
  }

  Future<void> changeStaffPassword() async {
    validate(true);
    if (MyTextFieldFormController.findController('New Password').isValid &&
        validator.value == null) {
      try {
        await ChangePasswordService().changeStaffPassword(
          id: user.value.id ?? "",
          newPassword: newPasswordController.text,
        );
        Get.back();
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response?.data["message"]);
        rethrow;
      }
    }
  }

  Future<void> changeUserPassword() async {
    validate(true);
    if (MyTextFieldFormController.findController('New Password').isValid &&
        validator.value == null) {
      try {
        ChangePasswordModel input = ChangePasswordModel(
          oldPassword: oldPasswordController.text,
          newPassword: newPasswordController.text,
        );
        await ChangePasswordService().changeUserPassword(input);
        Get.back();
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response?.data["message"]);
        rethrow;
      }
    }
  }

  void validate(bool? isStaffPassword) {
    MyTextFieldFormController.findController('New Password').isValid;
    MyTextFieldFormController.findController('Confirm Password').isValid;
    if (isStaffPassword == false) {
      MyTextFieldFormController.findController('Old Password').isValid;
    }
  }

  void onValidateConfirmPassword(String? value) {
    if (value != newPasswordController.text) {
      validator.value = "Password not match";
    } else {
      validator.value = null;
    }
  }

  void onTapShowOldPassword() {
    hideOldPassword.value = !hideOldPassword.value;
  }

  void onTapShowNewPassword() {
    hideNewPassword.value = !hideNewPassword.value;
  }
}
