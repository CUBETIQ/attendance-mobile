import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/console/console.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/extensions/string.dart';
import 'package:attendance_app/feature/profile/edit_profile/model/update_profile_model.dart';
import 'package:attendance_app/feature/profile/edit_profile/service/index.dart';
import 'package:attendance_app/feature/profile/profile/controller/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to => Get.find();
  Rx<UserModel> user = UserModel().obs;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments;
  }

  Future<void> updateProfile() async {
    isLoading.value = true;
    try {
      UpdateProfileModel input = UpdateProfileModel(
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        dob: dobController.text.toInt(),
        address: addressController.text,
        image: user.value.image,
      );
      Console.log("data", input.dob);
      await EditProfileService().updateProfile(input);
      await ProfileController.to.fetchMe();
      Get.back(closeOverlays: true);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response!.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
