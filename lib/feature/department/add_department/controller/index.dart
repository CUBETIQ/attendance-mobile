import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/network/file_upload/model/file_metadata.dart';
import 'package:timesync360/core/network/file_upload/upload_file_service.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/feature/department/add_department/model/add_department_model.dart';
import 'package:timesync360/feature/department/add_department/model/edit_department_model.dart';
import 'package:timesync360/feature/department/add_department/service/index.dart';
import 'package:timesync360/feature/department/department/controller/index.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/types/state.dart';
import '../../../../core/widgets/bottom_sheet/bottom_sheet.dart';

class AddDepartmentController extends GetxController {
  final title = "Add Department".obs;
  final state = AppState.create.obs;
  final image = Rxn<String>(null);
  final imageFile = Rxn<File>(null);
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final department = Rxn<DepartmentModel>(null);

  @override
  void onInit() {
    super.onInit();
    initArgument();
  }

  void initArgument() {
    final data = Get.arguments;
    state.value = data["state"];
    if (state.value == AppState.edit) {
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
      if (imageFile.value != null) {
        final metedata = FileMetadata(
          source: "department",
          userId: NavigationController.to.user.value.id,
        );
        final data =
            await UploadFileService().uploadFile(imageFile.value!, metedata);
        if (data != null) {
          image.value = data.url;
        }
      }
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
      if (imageFile.value != null) {
        final metedata = FileMetadata(
          source: "department",
          userId: NavigationController.to.user.value.id,
        );
        final data =
            await UploadFileService().uploadFile(imageFile.value!, metedata);
        if (data != null) {
          image.value = data.url;
        }
      }
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
      onTapGallery: (file) {
        imageFile.value = file;
      },
      onTapAvatar: (result, file) {
        image.value = result;
        imageFile.value = null;
      },
    );
  }

  void validate() {
    MyTextFieldFormController.findController('name').isValid;
  }
}
