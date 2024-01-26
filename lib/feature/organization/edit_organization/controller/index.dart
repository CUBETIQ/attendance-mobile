import 'dart:io';
import 'package:attendance_app/core/model/organization_model.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/console/console.dart';
import 'package:attendance_app/core/widgets/debouncer/debouncer.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/organization/edit_organization/model/update_organization_model.dart';
import 'package:attendance_app/feature/organization/edit_organization/service/index.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:attendance_app/utils/time_util.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditOrganizationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController startHourController = TextEditingController();
  TextEditingController endHourController = TextEditingController();
  TextEditingController breakStartHourController = TextEditingController();
  TextEditingController breakEndHourController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Rx<OrganizationModel> organization = OrganizationModel().obs;
  Rxn<File> imageFile = Rxn<File>(null);
  Rxn<String> image = Rxn<String>(null);
  final _debounce = Debouncer(milliseconds: 500);

  @override
  void onInit() {
    super.onInit();
    organization.value = Get.arguments;
    initArgument();
    test();
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

  void test() {
    String startHour = "8:00";
    String endHour = "15:45";

    // Parse startHour and endHour strings into DateTime objects
    DateTime startTime = DateFormat('H:mm').parse(startHour);
    DateTime endTime = DateFormat('H:mm').parse(endHour);

    // Calculate the duration between startTime and endTime
    Duration duration = endTime.difference(startTime);

    // Print the duration
    Console.log("Test",
        "Duration: ${duration.inHours} hours ${duration.inMinutes % 60} minutes");
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

  Future<void> updateOrganization() async {
    _debounce.run(() async {
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
    });
  }
}
