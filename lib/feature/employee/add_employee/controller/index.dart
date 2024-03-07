import 'dart:io';
import 'package:timesync/core/model/department_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/network/file_upload/model/file_metadata.dart';
import 'package:timesync/core/network/file_upload/upload_file_service.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/employee/add_employee/model/create_staff_model.dart';
import 'package:timesync/feature/employee/add_employee/model/update_staff_model.dart';
import 'package:timesync/feature/employee/add_employee/service/index.dart';
import 'package:timesync/feature/employee/employee/controller/index.dart';
import 'package:timesync/types/state.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/types/gender.dart';
import 'package:timesync/types/role.dart';
import 'package:timesync/types/user_status.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStaffController extends GetxController {
  final title = "Add Employee".obs;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final status = [
    UserStatus.active,
    UserStatus.doNotDisturb,
    UserStatus.idle,
  ];
  final genderList = [
    Gender.female,
    Gender.male,
    Gender.other,
  ].obs;
  final roleList = [
    Role.admin,
    Role.staff,
  ].obs;
  final positionList = <PositionModel>[].obs;
  final departmentList = <DepartmentModel>[].obs;
  final selectedPosition = Rxn<PositionModel>(null);
  final selectedDepartment = Rxn<DepartmentModel>(null);
  final selectedStatus = Rxn<String>(UserStatus.idle);
  final selectedRole = Rxn<String>(Role.staff);
  final selectedGender = Rxn<String>(Gender.male);
  final image = Rxn<String>(null);
  final imageFile = Rxn<File>(null);
  final staff = UserModel().obs;
  final dob = Rxn<int>(null);
  final appState = AppState.create.obs;

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  void getArgument() {
    if (Get.arguments != null) {
      appState.value = Get.arguments["state"];
      positionList.value = Get.arguments["positions"];
      departmentList.value = Get.arguments["departments"];
      if (appState.value == AppState.edit) {
        title.value = "Edit Employee";
        staff.value = Get.arguments["staff"];
        image.value = staff.value.image;
        usernameController.text = staff.value.username ?? "";
        firstnameController.text = staff.value.firstName ?? "";
        lastnameController.text = staff.value.lastName ?? "";
        addressController.text = staff.value.address ?? "";
        emailController.text = staff.value.email ?? "";
        dobController.text =
            DateUtil.formatMillisecondsToDOB(staff.value.dateOfBirth);
        dob.value = staff.value.dateOfBirth;
        selectedRole.value = staff.value.role ?? Role.staff;
        if (staff.value.departmentId != null &&
            staff.value.departmentId != "") {
          selectedDepartment.value = departmentList.value.firstWhere(
            (element) => element.id == staff.value.departmentId,
            orElse: () => departmentList.value.first,
          );
        }
        if (staff.value.positionId != null && staff.value.positionId != "") {
          selectedPosition.value = positionList.value.firstWhere(
            (element) => element.id == staff.value.positionId,
            orElse: () => positionList.value.first,
          );
        }
      }
    }
  }

  Future<void> onTapAddStaff() async {
    validate(true);
    if (MyTextFieldFormController.findController('Username').isValid &&
        MyTextFieldFormController.findController('Password').isValid &&
        MyTextFieldFormController.findController('Email').isValid) {
      try {
        if (imageFile.value != null) {
          final metedata = FileMetadata(
            source: "profile",
            userId: NavigationController.to.user.value.id,
          );
          final data =
              await UploadFileService().uploadFile(imageFile.value!, metedata);
          if (data != null) {
            image.value = data.url;
          }
        }
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
          image: image.value,
          name: "${firstnameController.text} ${lastnameController.text}",
          departmentId: selectedDepartment.value?.id,
          organizationId: NavigationController.to.organization.value.id,
          positionId: selectedPosition.value?.id,
          email: emailController.text,
        );
        await AddStaffService().addStaff(input);
        await StaffController.to.getAllStaffs();
        Get.back(closeOverlays: true);
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response?.data["message"]);
        rethrow;
      }
    }
  }

  Future<void> onTapUpdateStaff() async {
    validate(false);
    if (MyTextFieldFormController.findController('Username').isValid) {
      try {
        if (imageFile.value != null) {
          final metedata = FileMetadata(
            source: "profile",
            userId: NavigationController.to.user.value.id,
          );
          final data =
              await UploadFileService().uploadFile(imageFile.value!, metedata);
          if (data != null) {
            image.value = data.url;
          }
        }
        UpdateStaffModel input = UpdateStaffModel(
          username: usernameController.text,
          firstName: firstnameController.text,
          lastName: lastnameController.text,
          address: addressController.text,
          dateOfBirth: dob.value,
          role: selectedRole.value,
          gender: selectedGender.value,
          status: selectedStatus.value,
          name: "${firstnameController.text} ${lastnameController.text}",
          image: image.value,
          departmentId: selectedDepartment.value?.id,
          organizationId: NavigationController.to.organization.value.id,
          positionId: selectedPosition.value?.id,
          email: emailController.text,
        );
        await AddStaffService().updateStaff(input: input, id: staff.value.id!);
        await StaffController.to.getAllStaffs();
        if (NavigationController.to.user.value.id == staff.value.id) {
          await NavigationController.to.fetchMe();
        }
        Get.back(closeOverlays: true);
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response?.data["message"]);
        rethrow;
      }
    }
  }

  void pickImage() async {
    getPickImageButtomSheet(
      Get.context!,
      onTapGallery: (file) {
        imageFile.value = file;
      },
      onTapCamera: (file) {
        imageFile.value = file;
      },
      onTapAvatar: (result, file) {
        image.value = result;
        imageFile.value = file;
      },
    );
  }

  void getDateInMilliSecond(int? date) {
    dob.value = date;
  }

  void validate(bool? validatePassword) {
    MyTextFieldFormController.findController('Username').isValid;
    MyTextFieldFormController.findController('Email').isValid;
    if (validatePassword != null && validatePassword == true) {
      MyTextFieldFormController.findController('Password').isValid;
    }
  }
}
