import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/widgets/debouncer/debouncer.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/feature/position/add_position/model/add_position_model.dart';
import 'package:timesync360/feature/position/add_position/model/edit_position_model.dart';
import 'package:timesync360/feature/position/add_position/service/index.dart';
import 'package:timesync360/feature/position/position/controller/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:timesync360/types/avatar_type.dart';
import 'package:timesync360/types/state.dart';
import '../../../../core/widgets/bottom_sheet/bottom_sheet.dart';

class AddPositionController extends GetxController {
  RxString title = "Add Position".obs;
  RxString state = AppState.Create.obs;
  Rxn<String> image = Rxn<String>(null);
  Rxn<File> imageFile = Rxn<File>(null);
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Rxn<PositionModel> position = Rxn<PositionModel>(null);
  final _debounce = Debouncer(milliseconds: 500);

  @override
  void onInit() {
    super.onInit();
    initArgument();
  }

  void initArgument() {
    final data = Get.arguments;
    state.value = data["state"];
    if (state.value == AppState.Edit) {
      title.value = "Edit Position";
      position.value = data["position"];
      image.value = position.value?.image;
      nameController.text = position.value?.name ?? "";
      descriptionController.text = position.value?.description ?? "";
    }
  }

  Future<void> addPosition() async {
    _debounce.run(() async {
      validate();
      if (!MyTextFieldFormController.findController('name').isValid) {
        return;
      }
      try {
        final AddPositionModel input = AddPositionModel(
          name: nameController.text,
          description: descriptionController.text,
          image: image.value,
          organizationId: NavigationController.to.organization.value.id ?? "",
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
    });
  }

  Future<void> updatePosition() async {
    _debounce.run(() async {
      validate();
      if (!MyTextFieldFormController.findController('name').isValid) {
        return;
      }
      try {
        final EditPositionModel input = EditPositionModel(
          name: nameController.text,
          description: descriptionController.text,
          image: image.value,
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
    });
  }

  void pickImage() {
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
      arguments: AvatarType.position,
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

  void validate() {
    MyTextFieldFormController.findController('name').isValid;
  }
}
