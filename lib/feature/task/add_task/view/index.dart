import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/widgets/attachment/upload_button.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/color_picker/rounded_color_picker.dart';
import 'package:timesync/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync/core/widgets/icon_picker/rounded_icon_picker.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/textfield/date_picker_field.dart';
import 'package:timesync/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/feature/task/add_task/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:timesync/types/state.dart';
import 'package:timesync/utils/size_util.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize().paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
            vertical: SizeUtils.scale(
              AppSize().paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
          ),
          child: Column(
            children: [
              MyTextFieldForm(
                hasLabel: true,
                label: "Task",
                hintText: "Enter your task",
                textController: controller.taskController,
              ),
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
                  SizedBox(
                    width: SizeUtils.scale(AppSize().paddingS4, size.height),
                  ),
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
              Obx(
                () => MyDropDownButton<String>(
                  label: "Priority",
                  value: controller.selectPriority.value,
                  hint: "Choose position",
                  dropdownItems: controller.priority
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e.capitalizeFirst.trString),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      controller.selectPriority.value = value!,
                ),
              ),
              Obx(
                () => MyDropDownButton<String>(
                  label: "Status",
                  value: controller.selectStatus.value,
                  hint: "Choose status",
                  dropdownItems: controller.status
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e.capitalizeFirst.trString),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => controller.selectStatus.value = value!,
                ),
              ),
              MyTextFieldForm(
                hasLabel: true,
                label: "Description",
                hintText: "Enter your description",
                textController: controller.descriptionController,
                maxlines: 5,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Obx(
                      () => RoundedIconPicker(
                        iconColor: Colors.white,
                        icon: controller.stringIcon.value,
                        label: controller.stringIconLabel.value,
                        baseColor: controller.color.value,
                        onTap: () => controller.onTapPickIcon(context),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => RoundedColorPicker(
                        color: controller.color.value,
                        label: controller.stringColorLabel.value,
                        onTap: () => controller.onTapPickColor(context),
                      ),
                    ),
                  ),
                ],
              ),
              UploadAttachmentButton(
                files: controller.attachments,
              ),
              SizedBox(
                height: SizeUtils.scale(AppSize().paddingS10, size.height),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: SizeUtils.scale(
                    AppSize().paddingS10,
                    size.width,
                  ),
                ),
                child: Column(
                  children: [
                    controller.appState.value == AppState.edit
                        ? MyAsyncButton(
                            title: "Delete",
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            margin: EdgeInsets.only(
                              bottom: SizeUtils.scale(
                                AppSize().paddingS4,
                                size.height,
                              ),
                            ),
                            onTap: () => controller
                                .deleteTask(controller.task.value!.id),
                          )
                        : const SizedBox.shrink(),
                    MyAsyncButton(
                      title: "Save",
                      onTap: controller.appState.value == AppState.edit
                          ? controller.updateTask
                          : controller.addTask,
                    ),
                  ],
                ),
              ),
            ].withSpaceBetween(
                height: SizeUtils.scale(AppSize().paddingS5, size.height)),
          ),
        ),
      ),
    );
  }
}
