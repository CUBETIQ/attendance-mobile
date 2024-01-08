import 'dart:io';

import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/staff/add_staff/model/create_staff_model.dart';
import 'package:attendance_app/feature/staff/add_staff/service/index.dart';
import 'package:attendance_app/utils/types_helper/gender.dart';
import 'package:attendance_app/utils/types_helper/role.dart';
import 'package:attendance_app/utils/types_helper/user_status.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/types_helper/state.dart';

class AddStaffController extends GetxController {
  RxString title = "Add Staff".obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<String> status = [
    UserStatus.active,
    UserStatus.doNotDisturb,
    UserStatus.idle,
  ];
  List<String> genderList = [
    Gender.female,
    Gender.male,
    Gender.other,
  ].obs;
  List<String> roleList = [
    Role.admin,
    Role.staff,
  ].obs;
  Rxn<String> selectedStatus = Rxn<String>(UserStatus.idle);
  Rxn<String> selectedRole = Rxn<String>(Role.staff);
  Rxn<String> selectedGender = Rxn<String>(Gender.male);
  Rxn<String> image = Rxn<String>(null);
  Rxn<File> imageFile = Rxn<File>(null);
  Rx<UserModel> staff = UserModel().obs;
  Rxn<int> dob = Rxn<int>(null);

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  Future<void> onTapAddStaff() async {
    try {
      CreateStaffModel input = CreateStaffModel(
          username: usernameController.text,
          password: passwordController.text,
          firstName: firstnameController.text,
          lastName: lastnameController.text,
          address: addressController.text,
          dateOfBirth: dob.value,
          role: selectedRole.value,
          gender: selectedGender.value,
          status: selectedStatus.value,
          name: "${firstnameController.text} ${lastnameController.text}",
          image: image.value,
          departmentId: "",
          organizationId: "",
          positionId: "");
      await AddStaffService().addStaff(input);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void getArgument() {
    if (Get.arguments != null) {
      if (Get.arguments["state"] == AppState.Edit) {
        title.value = "Edit Staff";
      } else {
        title.value = "Add Staff";
      }
    }
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        imageFile.value = File(file.path!);
      } else {
        return;
      }
    } catch (e) {
      rethrow;
    }
  }

  void getDateInMilliSecond(int? date) {
    dob.value = date;
  }
}
