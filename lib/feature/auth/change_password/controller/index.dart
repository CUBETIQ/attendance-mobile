import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/feature/auth/change_password/model/chnage_password_model.dart';
import 'package:timesync360/feature/auth/change_password/service/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final Rx<UserModel> user = UserModel().obs;
  final RxBool isChangeStaffPass = false.obs;
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final RxBool hideOldPassword = true.obs;
  final RxBool hideNewPassword = true.obs;

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
