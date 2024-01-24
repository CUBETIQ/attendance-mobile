import 'dart:io';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:attendance_app/feature/home/home/controller/index.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/profile/edit_profile/model/update_profile_model.dart';
import 'package:attendance_app/feature/profile/edit_profile/service/index.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:attendance_app/utils/time_util.dart';
import 'package:attendance_app/utils/types_helper/gender.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
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
  Rxn<String> image = Rxn<String>(null);
  Rxn<String> backUpImage = Rxn<String>(null);
  Rxn<int> dob = Rxn<int>(null);
  Rxn<File> imageFile = Rxn<File>(null);
  RxList<String> genderList = [
    Gender.female,
    Gender.male,
    Gender.other,
  ].obs;
  Rxn<String> selectedGender = Rxn<String>(null);

  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments;
    initData();
  }

  void initData() {
    firstnameController.text = user.value.firstName ?? "";
    lastnameController.text = user.value.lastName ?? "";
    addressController.text = user.value.address ?? "";
    image.value = user.value.image;
    backUpImage.value = user.value.image;
    selectedGender.value = user.value.gender;
    if (user.value.dateOfBirth != null &&
        user.value.dateOfBirth.toString().length > 5) {
      dobController.text =
          DateFormatter().formatMillisecondsToDOB(user.value.dateOfBirth);
    }
  }

  void getDateInMilliSecond(int? date) {
    dob.value = date;
  }

  Future<void> updateProfile() async {
    validate();
    if (MyTextFieldFormController.findController('First Name').isValid &&
        MyTextFieldFormController.findController('Last Name').isValid) {
      isLoading.value = true;
      try {
        UpdateProfileModel input = UpdateProfileModel(
          firstname: firstnameController.text,
          lastname: lastnameController.text,
          dob: dob.value,
          address: addressController.text,
          image: image.value,
          gender: selectedGender.value,
        );
        await EditProfileService().updateProfile(input);
        await NavigationController.to.fetchMe();
        HomeController.to.getUsername();
        Get.back(
          closeOverlays: true,
          result: NavigationController.to.user.value,
        );
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response!.data["message"]);
        rethrow;
      } finally {
        isLoading.value = false;
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
    final resultImage = await Get.toNamed(Routes.AVATAR);
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

  void validate() {
    MyTextFieldFormController.findController('First Name').isValid;
    MyTextFieldFormController.findController('Last Name').isValid;
  }
}
