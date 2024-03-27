import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/button/button.dart';
import 'package:timesync/core/widgets/check_box/check_box.dart';
import 'package:timesync/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync/core/widgets/textfield/texfield_validate.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/avatar_type.dart';
import 'package:timesync/types/task.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/pick_file_handler.dart';
import 'package:timesync/utils/size_util.dart';

void getAddTaskBottomSheet(
    {bool? isDismissible,
    required Future<void> Function(
            {TextEditingController? taskController,
            TextEditingController? descriptionController,
            DateTimeRange? dateTimeRange,
            bool? isUrgent,
            String? selectedStatus})
        onAddTask}) {
  final context = Get.context!;
  final size = MediaQuery.of(context).size;

  final dateLabel = Rxn<String>();
  final selectedStatus = TaskFilter.pending.obs;
  final status = [TaskFilter.pending, TaskFilter.completed];

  final addDescription = false.obs;
  final isUrgent = false.obs;

  TextEditingController? taskController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
  final dateTimeRange = Rxn<DateTimeRange>();

  Get.bottomSheet(
      isDismissible: isDismissible ?? true,
      isScrollControlled: true,
      Container(
        width: size.width,
        decoration: const BoxDecoration(
          color: MyColor.base2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSpacing.XL2),
            topRight: Radius.circular(AppSpacing.XL2),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            SizeUtils.scale(20, size.width),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: MyText(
                        text: 'Add Task',
                        style: AppFonts.TitleMedium.copyWith(
                            color: Theme.of(context).colorScheme.onBackground)),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                            height: SizeUtils.scale(48, size.width),
                            width: SizeUtils.scale(48, size.width),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                border: Border.all(color: MyColor.base5),
                                borderRadius:
                                    BorderRadius.circular(AppSpacing.L)),
                            child: SvgIcon(
                              icon: IconAssets.xClose,
                              height: SizeUtils.scale(10.5, size.width),
                              width: SizeUtils.scale(10.5, size.width),
                              color: Theme.of(context).colorScheme.onBackground,
                            )),
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.scale(24, size.width)),
                child: Column(
                  children: [
                    MyTextFieldForm(
                      label: 'Task',
                      hintText: "Enter your task",
                      textController: taskController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: SizeUtils.scale(24, size.width),
                              width: SizeUtils.scale(24, size.width),
                              child: Obx(() => MyCheckBox(
                                    isChecked: isUrgent.value,
                                    hasNoBackground: true,
                                    onTap: () {
                                      isUrgent.value = !isUrgent.value;
                                    },
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeUtils.scale(8, size.width)),
                              child: MyText(
                                  text: "Urgent",
                                  style: AppFonts.TitleSmall.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            MyText(
                              text: "Status",
                              style: AppFonts.LabelMedium.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                            Obx(() => MyDropDownButton<String>(
                                  width: SizeUtils.scale(120, size.width),
                                  borderColor:
                                      Theme.of(context).colorScheme.primary,
                                  buttonPadding: EdgeInsets.only(
                                      bottom: SizeUtils.scale(6, size.width)),
                                  dropdownPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeUtils.scale(10, size.width)),
                                  buttonDecoration: const BoxDecoration(),
                                  label: "Type",
                                  hasLabel: false,
                                  value: selectedStatus.value,
                                  hint: "Choose Type",
                                  dropdownItems: status
                                      .map(
                                        (e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: MyText(
                                            text: e.trString,
                                            style: AppFonts.TitleSmall.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    selectedStatus.value = value!;
                                  },
                                )),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                        height: SizeUtils.scale(1, size.width),
                        color: MyColor.base4),
                    GestureDetector(
                      onTap: () async {
                        final DateTimeRange? picked = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101),
                          locale: Get.locale,
                          helpText: 'Depart - Return dates',
                          cancelText: 'Cancel',
                          confirmText: 'Ok',
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                                  primary:
                                      Theme.of(context).colorScheme.primary,
                                  onPrimary:
                                      Theme.of(context).colorScheme.onPrimary,
                                  surface:
                                      Theme.of(context).colorScheme.surface,
                                  onSurface:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                dialogBackgroundColor:
                                    Theme.of(context).colorScheme.surface,
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          dateLabel.value =
                              '${DateUtil.formatMillisecondsToDOB(picked.start.millisecondsSinceEpoch)} - ${DateUtil.formatMillisecondsToDOB(picked.end.millisecondsSinceEpoch)}';
                          dateTimeRange.value = picked;
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SvgIcon(
                                icon: IconAssets.calendar,
                                height: SizeUtils.scale(24, size.width),
                                width: SizeUtils.scale(24, size.width),
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeUtils.scale(8, size.width)),
                              child: Obx(() => MyText(
                                    text: dateLabel.value ?? 'Add Dates',
                                    style: AppFonts.TitleSmall.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                        height: SizeUtils.scale(1, size.width),
                        color: MyColor.base4),
                    GestureDetector(
                      onTap: () {
                        addDescription.value = true;
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Obx(() {
                              return addDescription.value == true
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          right:
                                              SizeUtils.scale(8, size.width)),
                                      child: SvgIcon(
                                          icon: IconAssets.document,
                                          height:
                                              SizeUtils.scale(24, size.width),
                                          width:
                                              SizeUtils.scale(24, size.width),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                    );
                            }),
                            MyText(
                              text: 'Add Description',
                              style: AppFonts.TitleSmall.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )
                          ],
                        ),
                      ),
                    ),
                    Obx(() {
                      return addDescription.value == true
                          ? MyTextFieldForm(
                              label: "Description",
                              hintText: "Enter your task description",
                              textController: descriptionController,
                              maxlines: 5,
                            )
                          : const SizedBox.shrink();
                    }),
                    MyAsyncButton(
                      title: "Add Task",
                      onTap: () {
                        if (MyTextFieldFormController.findController('Task')
                            .isValid) {
                          return onAddTask(
                              taskController: taskController,
                              descriptionController: descriptionController,
                              dateTimeRange: dateTimeRange.value,
                              isUrgent: isUrgent.value,
                              selectedStatus: selectedStatus.value);
                        } else {
                          return Future.value();
                        }
                      },
                      hasShadow: true,
                    ),
                  ].withSpaceBetweenNoSizedBox(
                    height: SizeUtils.scale(16, size.width),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
}

void getCheckInBottomSheet(BuildContext context,
    {bool? isDismissible, required String image}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: size.height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50 * (size.width / 375.0)),
          topRight: Radius.circular(50 * (size.width / 375.0)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.25,
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: "You Have Checked In!",
              style: AppFonts().bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text:
                  "You have successfully checked in of your present! Good luck and have a nice day!",
              style: AppFonts().bodyMediumRegular,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.05),
              child: MyButton(
                title: "Close",
                onTap: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void getCheckOutBottomSheet(BuildContext context,
    {bool? isDismissible, required String image}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: size.height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50 * (size.width / 375.0)),
          topRight: Radius.circular(50 * (size.width / 375.0)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.25,
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: "You Have Checked Out!",
              style: AppFonts().bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text:
                  "You have successfully checked out of your present! Good bye and have a good rest!",
              style: AppFonts().bodyMediumRegular,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.05),
              child: MyButton(
                title: "Close",
                onTap: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void getConfirmCheckInOutBottomSheet({
  bool? confirmCheckIn,
  bool? isDismissible,
  void Function()? onTapConfirm,
  String? title,
  Color? titleColor,
  bool? isCheckOut,
}) {
  final context = Get.context!;
  final size = MediaQuery.of(context).size;
  confirmCheckIn == true
      ? {
          Get.bottomSheet(
            isDismissible: isDismissible ?? true,
            Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50 * (size.width / 375.0)),
                  topRight: Radius.circular(50 * (size.width / 375.0)),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeUtils.scale(
                    AppSize().paddingHorizontalLarge,
                    size.width,
                  ),
                  right: SizeUtils.scale(
                    AppSize().paddingHorizontalLarge,
                    size.width,
                  ),
                  top: AppSize().paddingTitleSmall,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              // width: size.width * 0.65,
                              // height: size.height * 0.25,
                              child: SvgPicture.asset(
                                isCheckOut == true
                                    ? SvgAssets.leaving
                                    : SvgAssets.working,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeUtils.scale(20, size.width)),
                            child: MyText(
                              text: title ??
                                  (isCheckOut == true
                                      ? "Are you sure you wanna check out?"
                                      : "Are you sure you wanna check in?"),
                              style: AppFonts().bodyMediumMedium.copyWith(
                                    color: titleColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeUtils.scale(20, size.width)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MyButton(
                              title: "Cancel",
                              onTap: () => Get.back(),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: MyButton(
                              title: "Confirm",
                              onTap: () {
                                onTapConfirm?.call();
                                Get.back();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        }
      : onTapConfirm?.call();
}

void getForgetCheckOutBottomSheet(BuildContext context,
    {bool? isDismissible, required String image, void Function()? onTap}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: size.height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50 * (size.width / 375.0)),
          topRight: Radius.circular(50 * (size.width / 375.0)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.25,
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: "You Have not checked out!",
              style: AppFonts().bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: "Are you sure you want to check out?",
              style: AppFonts().bodyMediumRegular,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.05),
              child: MyButton(
                backgroundColor: Theme.of(context).colorScheme.error,
                title: "Check Out",
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void getLogOutBottomSheet(
  BuildContext context, {
  bool? isDismissible,
  required String image,
  void Function()? onTapLogOut,
}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: size.height * 0.5,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50 * (size.width / 375.0)),
          topRight: Radius.circular(50 * (size.width / 375.0)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.25,
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: "Log Out",
              style: AppFonts().bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: "Are you sure you want to log out?",
              style: AppFonts().bodyMediumRegular,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyButton(
                      title: "Cancel",
                      onTap: () => Get.back(),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: MyButton(
                      title: "Confirm",
                      onTap: onTapLogOut,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void getConfirmBottomSheet(
  BuildContext context, {
  bool? isDismissible,
  required String image,
  void Function()? onTapConfirm,
  String? title,
  String? description,
  Color? titleColor,
}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: SizeUtils.scale(400, size.width),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50 * (size.width / 375.0)),
          topRight: Radius.circular(50 * (size.width / 375.0)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.25,
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: title ?? "Title",
              style: AppFonts().bodyLarge.copyWith(
                    color: titleColor,
                  ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: description ?? "Description",
              style: AppFonts().bodyMediumRegular,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyButton(
                      title: "Cancel",
                      onTap: () => Get.back(),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: MyButton(
                      title: "Confirm",
                      onTap: onTapConfirm,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void getEditAndDeleteBottomSheet(
  BuildContext context, {
  bool? isDismissible,
  required String image,
  void Function()? onTapDelete,
  void Function()? onTapEdit,
  String? title,
  String? description,
}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: SizeUtils.scale(370, size.width),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50 * (size.width / 375.0)),
          topRight: Radius.circular(50 * (size.width / 375.0)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.22,
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(height: SizeUtils.scale(40, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.edit_rounded,
              title: "Edit",
              onTap: onTapEdit,
            ),
            SizedBox(height: SizeUtils.scale(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.delete_rounded,
              title: "Delete",
              onTap: onTapDelete,
            ),
          ],
        ),
      ),
    ),
  );
}

void getEditDeleteViewBottomSheet(
  BuildContext context, {
  bool? isDismissible,
  required String image,
  void Function()? onTapDelete,
  void Function()? onTapEdit,
  void Function()? onTapView,
  String? title,
  String? description,
}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: SizeUtils.scale(435, size.width),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50 * (size.width / 375.0)),
          topRight: Radius.circular(50 * (size.width / 375.0)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.22,
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(height: SizeUtils.scale(35, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.visibility_rounded,
              title: "View Detail",
              onTap: onTapView,
            ),
            SizedBox(height: SizeUtils.scale(5, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.edit_rounded,
              title: "Edit",
              onTap: onTapEdit,
            ),
            SizedBox(height: SizeUtils.scale(5, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.delete_rounded,
              title: "Delete",
              onTap: onTapDelete,
            ),
          ],
        ),
      ),
    ),
  );
}

void getPickImageButtomSheet(
  BuildContext context, {
  bool? isDismissible,
  void Function(File file)? onTapGallery,
  void Function(String? image, File? file)? onTapAvatar,
  void Function(File file)? onTapCamera,
  String? firstButtonTitle,
  String? secondButtonTitle,
  IconData? firstButtonIcon,
  IconData? secondButtonIcon,
  IconData? thirdButtonIcon,
  String? avatarType,
}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: SizeUtils.scale(430, size.width),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50 * (size.width / 375.0)),
          topRight: Radius.circular(50 * (size.width / 375.0)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.22,
              child: SvgPicture.asset(
                SvgAssets.gallery,
              ),
            ),
            SizedBox(height: SizeUtils.scale(40, size.width)),
            MyButton(
              isIconButton: true,
              icon: firstButtonIcon ?? Icons.photo_rounded,
              title: firstButtonTitle ?? "Open Gallery",
              onTap: () async {
                Get.back();
                final file = await PickFileHandler.openGallery();
                if (file != null) {
                  onTapGallery?.call(file);
                }
              },
            ),
            SizedBox(height: SizeUtils.scale(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: thirdButtonIcon ?? Icons.camera_rounded,
              title: secondButtonTitle ?? "Open Camera",
              onTap: () async {
                Get.back();
                final file = await PickFileHandler.openCamera();
                if (file != null) {
                  onTapCamera?.call(file);
                }
              },
            ),
            SizedBox(height: SizeUtils.scale(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: secondButtonIcon ?? Icons.person_rounded,
              title: secondButtonTitle ?? "Default Avatar",
              onTap: () async {
                Get.back();
                File? file;
                final resultImage = await Get.toNamed(
                  Routes.AVATAR,
                  arguments: avatarType ?? AvatarType.profile,
                );
                if (resultImage != null) {
                  final image = resultImage;
                  file = null;
                  onTapAvatar?.call(image, file);
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}

void getPickIconButtomSheet(
  BuildContext context, {
  bool? isDismissible,
  void Function()? onTapGallery,
  void Function()? onTapAvatar,
  String? firstButtonTitle,
  String? secondButtonTitle,
  IconData? firstButtonIcon,
  IconData? secondButtonIcon,
}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: SizeUtils.scale(370, size.width),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50 * (size.width / 375.0)),
          topRight: Radius.circular(50 * (size.width / 375.0)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.22,
              child: SvgPicture.asset(
                SvgAssets.gallery,
              ),
            ),
            SizedBox(height: SizeUtils.scale(40, size.width)),
            MyButton(
              isIconButton: true,
              icon: firstButtonIcon ?? Icons.photo_rounded,
              title: firstButtonTitle ?? "Open Gallery",
              onTap: onTapGallery,
            ),
            SizedBox(height: SizeUtils.scale(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: secondButtonIcon ?? Icons.person_rounded,
              title: secondButtonTitle ?? "Default Avatar",
              onTap: onTapAvatar,
            ),
          ],
        ),
      ),
    ),
  );
}

void getOptionsBottomSheet(
  BuildContext context, {
  bool? isDismissible,
  required String image,
  void Function()? onTapChangePassword,
  void Function()? onTapDelete,
  void Function()? onTapEdit,
  String? title,
  String? description,
}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    isDismissible: isDismissible ?? true,
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50 * (size.width / 375.0)),
              topRight: Radius.circular(50 * (size.width / 375.0)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeUtils.scale(
                AppSize().paddingHorizontalLarge,
                size.width,
              ),
              right: SizeUtils.scale(
                AppSize().paddingHorizontalLarge,
                size.width,
              ),
              top: SizeUtils.scale(20, size.width),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: SizeUtils.scale(200, size.width),
                  height: SizeUtils.scale(140, size.width),
                  child: SvgPicture.asset(
                    image,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeUtils.scale(40, size.width)),
                  child: Column(
                    children: [
                      MyButton(
                        isIconButton: true,
                        icon: Icons.key_rounded,
                        title: "Change Password",
                        onTap: onTapChangePassword,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeUtils.scale(6, size.width)),
                        child: MyButton(
                          isIconButton: true,
                          icon: Icons.edit_rounded,
                          title: "Edit",
                          onTap: onTapEdit,
                        ),
                      ),
                      MyButton(
                        isIconButton: true,
                        icon: Icons.delete_rounded,
                        title: "Delete",
                        onTap: onTapDelete,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

void getPickAttachmentButtomSheet(
  BuildContext context, {
  bool? isDismissible,
  void Function(File file)? onTapGallery,
  void Function(File file)? onTapFile,
  void Function(File file)? onTapCamera,
  String? firstButtonTitle,
  String? secondButtonTitle,
  IconData? firstButtonIcon,
  IconData? secondButtonIcon,
  IconData? thirdButtonIcon,
  String? avatarType,
}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: SizeUtils.scale(430, size.width),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50 * (size.width / 375.0)),
          topRight: Radius.circular(50 * (size.width / 375.0)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.22,
              child: SvgPicture.asset(
                SvgAssets.gallery,
              ),
            ),
            SizedBox(height: SizeUtils.scale(40, size.width)),
            MyButton(
              isIconButton: true,
              icon: firstButtonIcon ?? Icons.photo_rounded,
              title: firstButtonTitle ?? "Open Gallery",
              onTap: () async {
                Get.back();
                final file = await PickFileHandler.openGallery();
                if (file != null) {
                  onTapGallery?.call(file);
                }
              },
            ),
            SizedBox(height: SizeUtils.scale(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: thirdButtonIcon ?? Icons.camera_rounded,
              title: secondButtonTitle ?? "Open Camera",
              onTap: () async {
                Get.back();
                final file = await PickFileHandler.openCamera();
                if (file != null) {
                  onTapCamera?.call(file);
                }
              },
            ),
            SizedBox(height: SizeUtils.scale(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: secondButtonIcon ?? Icons.file_open_rounded,
              title: secondButtonTitle ?? "Open File",
              onTap: () async {
                Get.back();
                final file = await PickFileHandler.openFileFolder();
                if (file != null) {
                  onTapFile?.call(file);
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
