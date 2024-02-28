import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/core/widgets/button/async_button.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/textfield/date_picker_field.dart';
import 'package:timesync360/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync360/extensions/string.dart';
import 'package:timesync360/feature/leave/add_leave/controller/index.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/types/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              AppSize().paddingHorizontalLarge,
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
                          child: Text(e.capitalizeFirst.trString),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      controller.selectLeaveType.value = value!,
                ),
              ),
              SizedBox(height: AppSize().paddingS5),
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
              SizedBox(height: AppSize().paddingS5),
              Obx(
                () => TypeAheadField<String>(
                  focusNode: controller.durationFocusNode,
                  controller: controller.durationController.value,
                  builder: (context, textController, focusNode) {
                    return MyTextFieldForm(
                      focusNode: focusNode,
                      hasLabel: true,
                      label: "Duration",
                      hintText: "Enter your duration",
                      textController: controller.durationController.value,
                    );
                  },
                  itemBuilder: (context, value) {
                    return ListTile(
                      title: Text(value),
                    );
                  },
                  onSelected: (value) {
                    controller.durationFocusNode?.unfocus();
                    controller.durationController.value.text = value;
                  },
                  suggestionsCallback: (String search) {
                    return controller.duration;
                  },
                ),
              ),
              SizedBox(height: AppSize().paddingS5),
              MyTextFieldForm(
                hasLabel: true,
                label: "Reason",
                hintText: "Enter your reason",
                textController: controller.reasonController,
                maxlines: 5,
              ),
              SizedBox(height: AppSize().paddingS5),
              SizedBox(height: size.height * 0.06),
              MyAsyncButton(
                title: "Save",
                onTap: controller.appState.value == AppState.edit
                    ? controller.updateLeave
                    : controller.addLeave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
