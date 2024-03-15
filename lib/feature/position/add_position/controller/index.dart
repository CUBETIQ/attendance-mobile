import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/core/model/department_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/network/file_upload/model/file_metadata.dart';
import 'package:timesync/core/network/file_upload/upload_file_service.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/position/add_position/model/add_position_model.dart';
import 'package:timesync/feature/position/add_position/model/edit_position_model.dart';
import 'package:timesync/feature/position/add_position/service/index.dart';
import 'package:timesync/feature/position/position/controller/index.dart';
import 'package:timesync/types/avatar_type.dart';
import 'package:timesync/types/state.dart';
import '../../../../core/widgets/bottom_sheet/bottom_sheet.dart';

class AddPositionController extends GetxController {
  final title = "Add Position".obs;
  final state = AppState.create.obs;
  final image = Rxn<String>(null);
  final imageFile = Rxn<File>(null);
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final position = Rxn<PositionModel>(null);
  final selectedDepartment = Rxn<DepartmentModel>(null);
  final departmentList = <DepartmentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initArgument();
  }

  void initArgument() {
    final data = Get.arguments;
    state.value = data["state"];
    departmentList.value = data["departments"];
    if (state.value == AppState.edit) {
      title.value = "Edit Position";
      position.value = data["position"];
      image.value = position.value?.image;
      nameController.text = position.value?.name ?? "";
      selectedDepartment.value = departmentList.firstWhereOrNull(
        (element) => element.id == position.value?.departmentId,
      );
      descriptionController.text = position.value?.description ?? "";
    }
  }

  Future<void> addPosition() async {
    validate();
    if (!MyTextFieldFormController.findController('name').isValid) {
      return;
    }
    try {
      if (imageFile.value != null) {
        final metedata = FileMetadata(
          source: "position",
          userId: NavigationController.to.user.value.id,
        );
        final data =
            await UploadFileService().uploadFile(imageFile.value!, metedata);
        if (data != null) {
          image.value = data.url;
        }
      }
      final AddPositionModel input = AddPositionModel(
        name: nameController.text,
        description: descriptionController.text,
        image: image.value,
        organizationId: NavigationController.to.organization.value.id ?? "",
        departmentId: selectedDepartment.value?.id ?? "",
      );
      position.value = await AddPositionService().addPosition(input);
      PositionController.to.positionListBackUp.value.add(position.value!);
      PositionController.to.positionList.value =
          PositionController.to.positionListBackUp.value;
      PositionController.to.positionListBackUp.refresh();
      PositionController.to.positionList.refresh();
      Get.back();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> updatePosition() async {
    validate();
    if (!MyTextFieldFormController.findController('name').isValid) {
      return;
    }
    try {
      if (imageFile.value != null) {
        final metedata = FileMetadata(
          source: "position",
          userId: NavigationController.to.user.value.id,
        );
        final data =
            await UploadFileService().uploadFile(imageFile.value!, metedata);
        if (data != null) {
          image.value = data.url;
        }
      }
      final EditPositionModel input = EditPositionModel(
        name: nameController.text,
        description: descriptionController.text,
        image: image.value,
        departmentId: selectedDepartment.value?.id ?? "",
      );
      await AddPositionService().updatePosition(
        position.value?.id ?? "",
        input,
      );
      await PositionController.to.getAllPositions();
      Get.back();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
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
      avatarType: AvatarType.position,
    );
  }

  void validate() {
    MyTextFieldFormController.findController('name').isValid;
  }
}
