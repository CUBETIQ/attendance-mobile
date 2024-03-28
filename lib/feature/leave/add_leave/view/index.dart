import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/widgets/attachment/upload_button.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/card/empty_card_with_height.dart';
import 'package:timesync/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/textfield/date_picker_field.dart';
import 'package:timesync/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync/core/widgets/textfield/time_picker_field.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/feature/leave/add_leave/controller/index.dart';
import 'package:timesync/types/state.dart';
import 'package:timesync/utils/size_util.dart';

class AddLeaveView extends StatelessWidget {
  const AddLeaveView({super.key});

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
              Row(
                children: [
                  Expanded(
                    child: MyDatePickerField(
                      hasLabel: true,
                      label: "From",
                      hintText: "Enter your start date",
                      textController: controller.startDateController,
                      onDateResult: controller.getStartDateInMilliSecond,
                      initialDate: DateTime.now(),
                    ),
                  ),
                  SizedBox(width: SizeUtils.scale(16, size.width)),
                  Expanded(
                    child: MyTimePickerField(
                      label: "Time",
                      hasLabel: true,
                      textController: controller.startHourController,
                      onDateResult: (value) {
                        controller.startTime.value = value;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
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
                  SizedBox(width: SizeUtils.scale(16, size.width)),
                  Expanded(
                    child: MyTimePickerField(
                      label: "Time ",
                      hasLabel: true,
                      textController: controller.endHourController,
                      onDateResult: (value) {
                        controller.endTime.value = value;
                      },
                    ),
                  ),
                ],
              ),
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ],
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
              MyTextFieldForm(
                hasLabel: true,
                label: "Reason",
                hintText: "Enter your reason",
                textController: controller.reasonController,
                maxlines: 5,
                errorText: "You must enter your reason.",
              ),
              UploadAttachmentButton(
                files: controller.attachments,
              ),
              const MyBottomPaddingCard(),
              MyAsyncButton(
                title: "Save",
                onTap: controller.appState.value == AppState.edit
                    ? controller.updateLeave
                    : controller.addLeave,
              ),
              const MyBottomPaddingCard(),
            ].withSpaceBetween(height: SizeUtils.scale(16, size.width)),
          ),
        ),
      ),
    );
  }
}
