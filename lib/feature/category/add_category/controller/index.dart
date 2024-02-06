import 'package:dio/dio.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:timesync360/core/widgets/icon_picker/icon_picker_dialog.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/feature/category/add_category/model/create_category_model.dart';
import 'package:timesync360/feature/category/add_category/service/index.dart';
import 'package:timesync360/feature/category/category/controller/index.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';

class AddCategoryController extends GetxController {
  final Rxn<String> stringIcon = Rxn<String>(null);
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final RxList<String> categoryTypes = <String>[].obs;
  final RxnString selectedCategoryType = RxnString(null);

  @override
  void onInit() {
    super.onInit();
    getCategoryType();
    Logger()
        .i(Theme.of(Get.context!).colorScheme.primary.value.toRadixString(16));
  }

  Future<void> getCategoryType() async {
    try {
      categoryTypes.value = await AddCategoryService().getCategoryType();
      selectedCategoryType.value = categoryTypes.first;
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> addCategory() async {
    validate();
    if (!MyTextFieldFormController.findController('Name').isValid) {
      return;
    }
    try {
      final CreateCategoryModel input = CreateCategoryModel(
        name: nameController.text,
        description: descriptionController.text,
        icon: stringIcon.value,
        type: selectedCategoryType.value,
        color: "0x${Theme.of(Get.context!).colorScheme.primary.hexCode}",
        organizationId: NavigationController.to.organization.value.id ?? "",
      );
      final result = await AddCategoryService().addCategory(input);
      CategoryController.to.categories.add(result);
      CategoryController.to.categories.refresh();
      Get.back();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void onchangeCategoryType(String? value) {
    selectedCategoryType.value = value ?? "";
  }

  void onTapPickIcon(BuildContext context) {
    Get.dialog(
      IconPicker(
        onChangeResult: (value) {
          stringIcon.value = value;
        },
      ),
    );
  }

  void validate() {
    MyTextFieldFormController.findController('Name').isValid;
  }
}
