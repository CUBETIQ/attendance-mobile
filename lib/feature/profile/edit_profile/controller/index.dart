import 'dart:io';
import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/network/file_upload/model/file_metadata.dart';
import 'package:timesync360/core/network/file_upload/upload_file_service.dart';
import 'package:timesync360/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/feature/home/home/controller/index.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/feature/profile/edit_profile/model/update_profile_model.dart';
import 'package:timesync360/feature/profile/edit_profile/service/index.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:timesync360/types/gender.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to => Get.find();
  final user = UserModel().obs;
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final isLoading = false.obs;
  final image = Rxn<String>(null);
  final backUpImage = Rxn<String>(null);
  final dob = Rxn<int>(null);
  final imageFile = Rxn<File>(null);
  final genderList = [
    Gender.female,
    Gender.male,
    Gender.other,
  ].obs;
  final selectedGender = Rxn<String>(null);

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
          DateFormatter.formatMillisecondsToDOB(user.value.dateOfBirth);
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

  void validate() {
    MyTextFieldFormController.findController('First Name').isValid;
    MyTextFieldFormController.findController('Last Name').isValid;
  }
}
