import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/database/isar/service/isar_service.dart';
import 'package:attendance_app/core/model/summary_attendance_model.dart';
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
  RxList<SummaryAttendanceModel> summaryAttendance =
      <SummaryAttendanceModel>[].obs;
  Rxn<int> totalAttendance = Rxn<int>(null);
  Rxn<int> totalAbsent = Rxn<int>(null);
  Rxn<int> totalLeave = Rxn<int>(null);

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
    getSummarizeAttendance();
  }

  Future<void> onRefresh() async {
    await NavigationController.to.fetchMe();
    user.value = NavigationController.to.user.value;
    getUsername();
    getSummarizeAttendance();
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
          await IsarService().clearLocalData(deleteToken: true);
          Get.offAllNamed(Routes.LOGIN);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editProfile() async {
    final result =
        await Get.toNamed(Routes.EDIT_PROFILE, arguments: user.value);
    UserModel? data = result;
    if (data != null) {
      user.value = data;
      getUsername();
    }
  }

  Future<void> getSummarizeAttendance() async {
    totalAbsent.value = 0;
    totalLeave.value = 0;
    totalAttendance.value = 0;
    try {
      summaryAttendance.value = await ProfileService().getSummrizeAttendance();
      for (int i = 0; i < summaryAttendance.length; i++) {
        totalAbsent.value =
            (totalAbsent.value ?? 0) + (summaryAttendance[i].totalAbsent ?? 0);
        totalLeave.value =
            (totalLeave.value ?? 0) + (summaryAttendance[i].totalLeave ?? 0);
        totalAttendance.value = (totalAttendance.value ?? 0) +
            (summaryAttendance[i].totalAttendance ?? 0);
      }
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }
}
