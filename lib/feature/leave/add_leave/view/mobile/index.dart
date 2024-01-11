import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/core/widgets/textfield/date_picker_field.dart';
import 'package:attendance_app/core/widgets/textfield/texfield_validate.dart';
import 'package:attendance_app/feature/leave/add_leave/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/types_helper/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/button/button.dart';

class AddLeaveViewMobile extends StatelessWidget {
  const AddLeaveViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddLeaveController());
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
              AppSize.paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),
              Obx(
                () => MyDropDownButton<String>(
                  label: "Leave Type",
                  value: controller.selectLeaveType.value,
                  hint: "Choose leave type",
                  dropdownItems: controller.leaveTypes
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e.capitalizeFirst),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      controller.selectLeaveType.value = value!,
                ),
              ),
              const SizedBox(height: AppSize.paddingS5),
              Row(
                children: [
                  Expanded(
                    child: MyDatePickerField(
                      hasLabel: true,
                      label: "From",
                      hintText: "Enter your start date",
                      textController: controller.startDateController,
                      onDateResult: controller.getStartDateInMilliSecond,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: Obx(
                      () => MyDatePickerField(
                        hasLabel: true,
                        label: "To",
                        hintText: "Enter your end date",
                        initialDate: controller.startDate.value != null
                            ? DateTime.fromMillisecondsSinceEpoch(
                                controller.startDate.value!)
                            : null,
                        firstDate: DateTime.fromMillisecondsSinceEpoch(
                            controller.startDate.value!),
                        textController: controller.endDateController,
                        onDateResult: controller.getEndDateInMilliSecond,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.paddingS5),
              MyTextFieldForm(
                hasLabel: true,
                label: "Reason",
                hintText: "Enter your Reason",
                textController: controller.reasonController,
                maxlines: 5,
              ),
              const SizedBox(height: AppSize.paddingS5),
              // ToDo Convert This Into Smaller Widget
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Leave Duration Type",
                    style: BodyMediumMedium,
                  ),
                  const SizedBox(height: AppSize.paddingS5),
                  Container(
                    height: 48 * (size.width / 375.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        (AppSize.borderRadiusLarge) * (size.width / 375.0),
                      ),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.9),
                      ),
                    ),
                    child: Row(
                      children: List.generate(
                        controller.leaveTypeDuration.length,
                        (index) => Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                controller.onChnageLeaveDurationType(index),
                            child: Obx(
                              () => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    (AppSize.borderRadiusLarge) *
                                        (size.width / 375.0),
                                  ),
                                  color: controller
                                              .selectLeaveDurationType.value ==
                                          controller.leaveTypeDuration[index]
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.9)
                                      : Colors.transparent,
                                ),
                                child: MyText(
                                  text: controller.leaveTypeDuration[index],
                                  style: BodyMediumMedium.copyWith(
                                    color: controller.selectLeaveDurationType
                                                .value ==
                                            controller.leaveTypeDuration[index]
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //
                  SizedBox(height: size.height * 0.06),
                  MyButton(
                    title: "Save",
                    onTap: controller.appState.value == AppState.Edit
                        ? controller.updateLeave
                        : controller.addLeave,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
