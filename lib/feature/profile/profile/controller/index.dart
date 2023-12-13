import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/database/isar/service/isar_service.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/profile/profile/model/option_model.dart';
import 'package:attendance_app/feature/profile/profile/service/index.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  Rx<UserModel> user = UserModel().obs;
  Rxn<String> name = Rxn<String>(null);
  late List<OptionModel> options;

  @override
  void onInit() {
    super.onInit();
    user.value = NavigationController.to.user.value;
    getUsername();
    options = [
      OptionModel(
        title: "Edit Profile",
        icon: Icons.edit,
        onTap: editProfile,
      ),
      OptionModel(
        title: "Logout",
        icon: Icons.logout,
        onTap: logout,
      ),
    ];
  }

  Future<void> fetchMe() async {
    try {
      user.value = await ProfileService().fetchMe();
      getUsername();
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

  void logout() {
    try {
      getLogOutBottomSheet(
        Get.context!,
        image: leaving,
        onTapLogOut: () async {
          await IsarService().clearLocalData();
          Get.offAllNamed(Routes.LOGIN);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  void editProfile() {
    Get.toNamed(Routes.EDIT_PROFILE, arguments: user.value);
  }
}
