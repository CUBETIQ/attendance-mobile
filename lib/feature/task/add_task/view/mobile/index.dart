import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/core/widgets/button/async_button.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/color_picker/rounded_color_picker.dart';
import 'package:timesync360/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync360/core/widgets/icon_picker/rounded_icon_picker.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/textfield/date_picker_field.dart';
import 'package:timesync360/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync360/feature/task/add_task/controller/index.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/types/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskViewMobile extends StatelessWidget {
  const AddTaskViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTaskController());
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
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize().paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),
              MyTextFieldForm(
                hasLabel: true,
                label: "Task",
                hintText: "Enter your task",
                textController: controller.taskController,
              ),
              SizedBox(height: AppSize().paddingS5),
              Row(
                children: [
                  Expanded(
                    child: MyDatePickerField(
                      hasLabel: true,
                      label: "Start Date",
                      hintText: "Select Date",
                      textController: controller.startDateController,
                      onDateResult: controller.getStartDateInMilliSecond,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: MyDatePickerField(
                      hasLabel: true,
                      label: "Due Date",
                      hintText: "Select Date",
                      initialDate: controller.startDate.value != null
                          ? DateTime.fromMillisecondsSinceEpoch(
                              controller.startDate.value!,
                            )
                          : DateTime.now(),
                      firstDate: controller.startDate.value != null
                          ? DateTime.fromMillisecondsSinceEpoch(
                              controller.startDate.value!,
                            )
                          : DateTime.now(),
                      textController: controller.endDateController,
                      onDateResult: controller.getEndDateInMilliSecond,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize().paddingS5),
              Obx(
                () => MyDropDownButton<String>(
                  label: "Priority",
                  value: controller.selectPriority.value,
                  hint: "Choose position",
                  dropdownItems: controller.priority
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e.capitalizeFirst),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      controller.selectPriority.value = value!,
                ),
              ),
              SizedBox(height: AppSize().paddingS5),
              MyTextFieldForm(
                hasLabel: true,
                label: "Description",
                hintText: "Enter your description",
                textController: controller.descriptionController,
                maxlines: 5,
              ),
              SizedBox(height: AppSize().paddingS5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => RoundedIconPicker(
                      iconColor: Colors.white,
                      icon: controller.stringIcon.value,
                      baseColor: controller.color.value,
                      onTap: () => controller.onTapPickIcon(context),
                    ),
                  ),
                  Obx(
                    () => RoundedColorPicker(
                      color: controller.color.value,
                      onTap: () => controller.onTapPickColor(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.06),
              MyAsyncButton(
                title: "Save",
                onTap: controller.appState.value == AppState.edit
                    ? controller.updateTask
                    : controller.addTask,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
