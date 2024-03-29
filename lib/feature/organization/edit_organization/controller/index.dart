import 'dart:io';
import 'package:timesync/core/model/organization_model.dart';
import 'package:timesync/core/network/file_upload/model/file_metadata.dart';
import 'package:timesync/core/network/file_upload/upload_file_service.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/organization/edit_organization/model/update_organization_model.dart';
import 'package:timesync/feature/organization/edit_organization/service/index.dart';
import 'package:timesync/types/avatar_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/utils/logger.dart';

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
  final startTime = Rxn<String>(null);
  final endTime = Rxn<String>(null);
  final breakStartTime = Rxn<String>(null);
  final breakEndTime = Rxn<String>(null);

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
      avatarType: AvatarType.organization,
    );
  }

  Future<void> updateOrganization() async {
    try {
      if (imageFile.value != null) {
        final metedata = FileMetadata(
          source: "organization",
          userId: NavigationController.to.user.value.id,
        );
        final data =
            await UploadFileService().uploadFile(imageFile.value!, metedata);
        if (data != null) {
          image.value = data.url;
        }
      }
      ConfigsModel configs = ConfigsModel(
        startHour: startTime.value,
        endHour: endTime.value,
        breakTime: "${breakStartTime.value}-${breakEndTime.value}",
      );

      Logs.i("Configs: ${configs.toJson()}");
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
