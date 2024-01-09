import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:attendance_app/feature/auth/change_password/model/chnage_password_model.dart';
import 'package:attendance_app/feature/auth/change_password/service/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  Rx<UserModel> user = UserModel().obs;
  RxBool isChangeStaffPass = false.obs;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  RxBool hideOldPassword = true.obs;
  RxBool hideNewPassword = true.obs;

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
    if (MyTextFieldFormController.findController('New Password').isValid) {
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
    if (MyTextFieldFormController.findController('New Password').isValid) {
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
    if (isStaffPassword == false) {
      MyTextFieldFormController.findController('Old Password').isValid;
    }
  }

  void onTapShowOldPassword() {
    hideOldPassword.value = !hideOldPassword.value;
  }

  void onTapShowNewPassword() {
    hideNewPassword.value = !hideNewPassword.value;
  }
}
