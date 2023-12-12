import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/profile/model/option_model.dart';
import 'package:attendance_app/feature/profile/service/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  Rx<UserModel> user = UserModel().obs;
  Rxn<String> name = Rxn<String>(null);
  List<OptionModel> options = [
    OptionModel(
      title: "Edit Profile",
      icon: Icons.edit,
    ),
    OptionModel(
      title: "Change Password",
      icon: Icons.lock,
    ),
    OptionModel(
      title: "Logout",
      icon: Icons.logout,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    user.value = NavigationController.to.user.value;
    getUsername();
  }

  Future<void> fetchMe() async {
    try {
      user.value = await ProfileService().fetchMe();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void getUsername() {
    if (user.value.firstName != null ||
        user.value.firstName != "" ||
        user.value.lastName != null ||
        user.value.lastName != "") {
      name.value = "${user.value.firstName} ${user.value.lastName}";
    } else {
      name.value = user.value.username;
    }
  }
}
