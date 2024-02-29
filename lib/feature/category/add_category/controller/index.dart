import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:timesync360/core/model/category_model.dart';
import 'package:timesync360/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync360/core/widgets/color_picker/color_picker_dialog.dart';
import 'package:timesync360/core/widgets/icon_picker/icon_picker_dialog.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/extensions/string.dart';
import 'package:timesync360/feature/category/add_category/model/create_category_model.dart';
import 'package:timesync360/feature/category/add_category/model/update_category_model.dart';
import 'package:timesync360/feature/category/add_category/service/index.dart';
import 'package:timesync360/feature/category/category/controller/index.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/types/state.dart';

class AddCategoryController extends GetxController {
  final stringIcon = Rxn<String>(null);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final categoryTypes = <String>[].obs;
  final selectedCategoryType = RxnString(null);
  late Color screenPickerColor;
  final color = Rxn<Color>(null);
  final stringColor = Rxn<String>(null);
  final title = "Add Category".tr.obs;
  final appState = AppState.create.obs;
  final category = CategoryModel().obs;

  @override
  void onInit() {
    super.onInit();
    getArgument();
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
        color: stringColor.value,
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

  Future<void> updateCategory() async {
    validate();
    if (!MyTextFieldFormController.findController('Name').isValid) {
      return;
    }
    try {
      final UpdateCategoryModel input = UpdateCategoryModel(
        name: nameController.text,
        description: descriptionController.text,
        icon: stringIcon.value,
        type: selectedCategoryType.value,
        color: stringColor.value,
      );
      await AddCategoryService().updateCategory(category.value.id ?? "", input);
      CategoryController.to.getAllCategory();
      Get.back();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getArgument() async {
    final data = Get.arguments;
    await getCategoryType();
    if (data != null) {
      appState.value = data["state"];
      if (appState.value == AppState.edit) {
        title.value = "Edit Category".trString;
        category.value = data["category"];
        Logger().i(category);
        nameController.text = category.value.name ?? "";
        descriptionController.text = category.value.description ?? "";
        selectedCategoryType.value = category.value.type;
        stringIcon.value = category.value.icon;
        stringColor.value = category.value.color;
        color.value = Color(int.parse(category.value.color ?? "0xFF000000"));
      }
    }
  }

  void onchangeCategoryType(String? value) {
    selectedCategoryType.value = value ?? "";
  }

  void onTapImage(BuildContext context) {
    getPickIconButtomSheet(
      Get.context!,
      onTapGallery: onTapPickIcon,
      onTapAvatar: () => onTapPickColor(context),
      firstButtonTitle: "Pick Icon".trString,
      secondButtonTitle: "Pick Color".trString,
      secondButtonIcon: Icons.color_lens_rounded,
    );
  }

  void onTapPickColor(BuildContext context) {
    Get.back();
    screenPickerColor = Colors.blue;
    getColorPickerDialog(
      context: context,
      screenPickerColor: screenPickerColor,
      onChangeResult: (colorString, value) {
        stringColor.value = colorString;
        color.value = value;
      },
      onCancel: () {
        String? colorString = Theme.of(context).colorScheme.primary.toString();
        RegExp regExp = RegExp(r'0x([0-9a-fA-F]+)');
        Match? match = regExp.firstMatch(colorString);
        color.value = Theme.of(context).colorScheme.primary;
        stringColor.value = match?.group(0) ?? '';
        Get.back();
      },
      onConfirm: () {
        Get.back();
      },
    );
  }

  void onTapPickIcon() {
    Get.back();
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
