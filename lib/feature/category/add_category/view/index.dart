import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync/core/widgets/icon_picker/rounded_icon_picker.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/feature/category/add_category/controller/index.dart';
import 'package:timesync/types/state.dart';
import 'package:timesync/utils/size_util.dart';

class AddCategoryView extends StatelessWidget {
  const AddCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddCategoryController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => MyAppBarTitle(
            title: controller.title.value,
          ),
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeUtils.scale(10, size.width),
            horizontal: SizeUtils.scale(24, size.width),
          ),
          child: Column(
            children: [
              SizedBox(height: SizeUtils.scale(10, size.width)),
              Obx(
                () => RoundedIconPicker(
                  hasOpacity: true,
                  mainAxisAlignment: MainAxisAlignment.center,
                  onTap: () => controller.onTapImage(context),
                  haslabel: false,
                  color: controller.color.value,
                  icon: controller.stringIcon.value,
                  width: SizeUtils.scale(100, size.width),
                  height: SizeUtils.scale(100, size.width),
                  iconSize: 50,
                ),
              ),
              SizedBox(height: SizeUtils.scale(30, size.width)),
              MyTextFieldForm(
                label: "Name",
                hasLabel: true,
                textController: controller.nameController,
              ),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              Obx(
                () => MyDropDownButton<String>(
                  isRoundedCorner: false,
                  label: "Type",
                  hasLabel: true,
                  value: controller.selectedCategoryType.value,
                  hint: "Choose Category",
                  dropdownItems: controller.categoryTypes
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e.capitalizeFirst.trString),
                        ),
                      )
                      .toList(),
                  onChanged: controller.onchangeCategoryType,
                ),
              ),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              MyTextFieldForm(
                label: "Description",
                hasLabel: true,
                maxlines: 5,
                textController: controller.descriptionController,
              ),
              SizedBox(height: SizeUtils.scale(20, size.width)),
              MyAsyncButton(
                title: "Save",
                onTap: controller.appState.value == AppState.create
                    ? controller.addCategory
                    : controller.updateCategory,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
