import 'package:timesync/core/model/summary_attendance_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/profile/profile/model/option_model.dart';
import 'package:timesync/feature/profile/profile/service/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  final user = UserModel().obs;
  final name = Rxn<String>(null);
  late List<OptionModel> options;
  final summaryAttendance = <SummaryAttendanceModel>[].obs;
  final totalAttendance = Rxn<int>(null);
  final totalAbsent = Rxn<int>(null);
  final totalLeave = Rxn<int>(null);

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
        title: "Change Password",
        icon: Icons.key_rounded,
        onTap: changePassword,
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

  void changePassword() {
    Get.toNamed(
      Routes.CHANGE_PASSWORD,
      arguments: {"data": user.value, "isStaff": false},
    );
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
