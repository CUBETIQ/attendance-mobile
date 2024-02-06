import 'dart:io';
import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/feature/employee/add_employee/model/create_staff_model.dart';
import 'package:timesync360/feature/employee/add_employee/model/update_staff_model.dart';
import 'package:timesync360/feature/employee/add_employee/service/index.dart';
import 'package:timesync360/feature/employee/employee/controller/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:timesync360/types/state.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:timesync360/types/avatar_type.dart';
import 'package:timesync360/types/gender.dart';
import 'package:timesync360/types/role.dart';
import 'package:timesync360/types/user_status.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStaffController extends GetxController {
  RxString title = "Add Employee".obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
  RxList<String> genderList = [
    Gender.female,
    Gender.male,
    Gender.other,
  ].obs;
  RxList<String> roleList = [
    Role.admin,
    Role.staff,
  ].obs;
  RxList<PositionModel> positionList = <PositionModel>[].obs;
  RxList<DepartmentModel> departmentList = <DepartmentModel>[].obs;
  Rxn<PositionModel> selectedPosition = Rxn<PositionModel>(null);
  Rxn<DepartmentModel> selectedDepartment = Rxn<DepartmentModel>(null);
  Rxn<String> selectedStatus = Rxn<String>(UserStatus.idle);
  Rxn<String> selectedRole = Rxn<String>(Role.staff);
  Rxn<String> selectedGender = Rxn<String>(Gender.male);
  Rxn<String> image = Rxn<String>(null);
  Rxn<File> imageFile = Rxn<File>(null);
  Rx<UserModel> staff = UserModel().obs;
  Rxn<int> dob = Rxn<int>(null);
  Rx<String> appState = AppState.Create.obs;

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
      if (appState.value == AppState.Edit) {
        title.value = "Edit Employee";
        staff.value = Get.arguments["staff"];
        image.value = staff.value.image;
        usernameController.text = staff.value.username ?? "";
        firstnameController.text = staff.value.firstName ?? "";
        lastnameController.text = staff.value.lastName ?? "";
        addressController.text = staff.value.address ?? "";
        emailController.text = staff.value.email ?? "";
        dobController.text =
            DateFormatter().formatMillisecondsToDOB(staff.value.dateOfBirth);
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

  Future<void> pickImage() async {
    getPickImageButtomSheet(
      Get.context!,
      onTapGallery: onTapGallery,
      onTapAvatar: onTapAvatar,
    );
  }

  Future<void> onTapAvatar() async {
    Get.back();
    final resultImage = await Get.toNamed(
      Routes.AVATAR,
      arguments: AvatarType.profile,
    );
    if (resultImage != null) {
      image.value = resultImage;
      imageFile.value = null;
    }
  }

  Future<void> onTapGallery() async {
    Get.back();
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

  void validate(bool? validatePassword) {
    MyTextFieldFormController.findController('Username').isValid;
    MyTextFieldFormController.findController('Email').isValid;
    if (validatePassword != null && validatePassword == true) {
      MyTextFieldFormController.findController('Password').isValid;
    }
  }
}
