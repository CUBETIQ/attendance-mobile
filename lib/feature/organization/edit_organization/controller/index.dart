import 'dart:io';
import 'package:timesync360/core/model/organization_model.dart';
import 'package:timesync360/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/feature/organization/edit_organization/model/update_organization_model.dart';
import 'package:timesync360/feature/organization/edit_organization/service/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync360/types/avatar_type.dart';

class EditOrganizationController extends GetxController {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final startHourController = TextEditingController();
  final endHourController = TextEditingController();
  final breakStartHourController = TextEditingController();
  final breakEndHourController = TextEditingController();
  final descriptionController = TextEditingController();
  final organization = OrganizationModel().obs;
  final imageFile = Rxn<File>(null);
  final image = Rxn<String>(null);

  @override
  void onInit() {
    super.onInit();
    organization.value = Get.arguments;
    initArgument();
  }

  void initArgument() {
    nameController.text = organization.value.name ?? "";
    addressController.text = organization.value.address ?? "";
    startHourController.text = organization.value.configs?.startHour ?? "";
    endHourController.text = organization.value.configs?.endHour ?? "";
    breakStartHourController.text =
        organization.value.configs?.breakTime?.split("-")[0] ?? "";
    breakEndHourController.text =
        organization.value.configs?.breakTime?.split("-")[1] ?? "";
    descriptionController.text = organization.value.description ?? "";
    image.value = organization.value.image ?? "";
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
      arguments: AvatarType.organization,
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

  Future<void> updateOrganization() async {
    try {
      ConfigsModel configs = ConfigsModel(
        startHour: startHourController.text,
        endHour: endHourController.text,
        breakTime:
            "${breakStartHourController.text}-${breakEndHourController.text}",
        breakDuration: DateTimeUtil().calculateDuration(
          breakStartHourController.text,
          breakEndHourController.text,
        ),
      );
      UpdateOrganizationModel input = UpdateOrganizationModel(
        name: nameController.text,
        description: descriptionController.text,
        image: image.value,
        address: addressController.text,
        configs: configs,
      );
      await EditOrganizationService()
          .updateOrganization(id: organization.value.id!, input: input);
      Get.back(result: 1);
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }
}
