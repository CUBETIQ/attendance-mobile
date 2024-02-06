import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/feature/department/add_department/model/add_department_model.dart';
import 'package:timesync360/feature/department/add_department/model/edit_department_model.dart';
import 'package:timesync360/feature/department/add_department/service/index.dart';
import 'package:timesync360/feature/department/department/controller/index.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:timesync360/types/avatar_type.dart';
import 'package:timesync360/types/state.dart';
import '../../../../core/widgets/bottom_sheet/bottom_sheet.dart';

class AddDepartmentController extends GetxController {
  RxString title = "Add Department".obs;
  RxString state = AppState.Create.obs;
  Rxn<String> image = Rxn<String>(null);
  Rxn<File> imageFile = Rxn<File>(null);
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Rxn<DepartmentModel> department = Rxn<DepartmentModel>(null);

  @override
  void onInit() {
    super.onInit();
    initArgument();
  }

  void initArgument() {
    final data = Get.arguments;
    state.value = data["state"];
    if (state.value == AppState.Edit) {
      title.value = "Edit Department";
      department.value = data["department"];
      image.value = department.value?.image;
      nameController.text = department.value?.name ?? "";
      descriptionController.text = department.value?.description ?? "";
    }
  }

  Future<void> addDepartment() async {
    validate();
    if (!MyTextFieldFormController.findController('name').isValid) {
      return;
    }
    try {
      final AddDepartmentModel input = AddDepartmentModel(
        name: nameController.text,
        description: descriptionController.text,
        image: image.value,
        organizationId: NavigationController.to.organization.value.id ?? "",
      );
      department.value = await AddDepartmentService().addDepartment(input);
      DepartmentController.to.departmentListBackUp.value.add(department.value!);
      DepartmentController.to.departmentList.value =
          DepartmentController.to.departmentListBackUp.value;
      DepartmentController.to.departmentListBackUp.refresh();
      DepartmentController.to.departmentList.refresh();
      Get.back();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> updateDepartment() async {
    validate();
    if (!MyTextFieldFormController.findController('name').isValid) {
      return;
    }
    try {
      final EditDepartmentModel input = EditDepartmentModel(
        name: nameController.text,
        description: descriptionController.text,
        image: image.value,
      );
      await AddDepartmentService().updateDepartment(
        department.value?.id ?? "",
        input,
      );
      await DepartmentController.to.getAllDepartments();
      Get.back();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
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
