import 'package:dio/dio.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync360/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync360/core/widgets/color_picker/color_picker_dialog.dart';
import 'package:timesync360/core/widgets/icon_picker/icon_picker_dialog.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/extensions/string.dart';
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
  late Color screenPickerColor;
  final Rxn<Color> color = Rxn<Color>(null);
  final Rxn<String> stringColor = Rxn<String>(null);

  @override
  void onInit() {
    super.onInit();
    getCategoryType();
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

  void onchangeCategoryType(String? value) {
    selectedCategoryType.value = value ?? "";
  }

  void onTapImage(BuildContext context) {
    getPickImageButtomSheet(
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
