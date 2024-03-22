import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/constants/app_shadow.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/database/isar/model/local_storage_model.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/feature/home/home/controller/index.dart';
import 'package:timesync/feature/home/home/widget/attendance_button.dart';
import 'package:timesync/feature/home/home/widget/timer_widget.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/logger.dart';
import 'package:timesync/utils/size_util.dart';

class AttendanceCard extends StatelessWidget {
  final bool? isCheckedIn;
  final String currentDate;
  final Future<void> Function() onCheckIn;
  final Future<void> Function() onCheckOut;
  final Animation<double> scale;
  final double? height;
  final double? width;
  final double? buttonSize;
  final double? iconSize;
  final bool isInOfficeRange;
  final bool disableButton;
  final bool? isBreakTime;
  final bool? hasNoLunchBreak;

  const AttendanceCard({
    super.key,
    this.isCheckedIn,
    required this.currentDate,
    required this.onCheckIn,
    required this.onCheckOut,
    required this.scale,
    this.height,
    this.width,
    this.buttonSize,
    this.iconSize,
    this.isInOfficeRange = false,
    this.disableButton = false,
    this.isBreakTime,
    this.hasNoLunchBreak = false,
  });

  @override
  Widget build(BuildContext context) {
    RxBool isDisableButton = false.obs;
    final size = MediaQuery.of(context).size;
    final currentTime = DateTime.now().obs;
    final workingHour = Rxn<String>();
    final workingMinute = Rxn<String>();
    final workingSecond = Rxn<String>();

    Future<void> checkTimer() async {
      if (isCheckedIn == true) {
        if (HomeController.to.checkInTime.value != null &&
            HomeController.to.checkOutTime.value == null) {
          final checkInDateTime = DateTime.fromMillisecondsSinceEpoch(
            HomeController.to.attendanceList.last.checkInDateTime!,
          );
          // Update the working hour value every second
          Timer.periodic(
            const Duration(seconds: 1),
            (Timer timer) async {
              var duration = await HomeController.to
                  .checkTime()
                  .then((value) => value.difference(checkInDateTime));
              workingHour.value = duration.inHours.toString().padLeft(2, '0');
              var minutes = duration.inMinutes.remainder(60);
              workingMinute.value = minutes.toString().padLeft(2, '0');
              var seconds = duration.inSeconds.remainder(60);
              workingSecond.value = seconds.toString().padLeft(2, '0');
            },
          );
        }
      } else {
        Timer.periodic(const Duration(seconds: 1), (Timer t) async {
          currentTime.value = await HomeController.to.checkTime();
        });
      }
    }

    checkTimer();

    return isCheckedIn == true
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.scale(42.5, size.width)),
                child: Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TimerWidget(value: workingHour.value),
                      TimerWidget(value: workingMinute.value),
                      TimerWidget(value: workingSecond.value),
                    ].withDivide(
                        widget: MyText(
                      text: ':',
                      style: AppFonts.HeadlineMedium.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    )),
                  );
                }),
              ),
              // Indicator();
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.scale(20, size.width)),
                child: Column(
                  children: [
                    LinearPercentIndicator(
                      animation: true,
                      lineHeight: SizeUtils.scale(5, size.width),
                      animationDuration: 250,
                      padding: EdgeInsets.zero,
                      percent: 0.02,
                      barRadius: Radius.circular(
                        SizeUtils.scale(
                            AppSize().borderRadiusLarge, size.width),
                      ),
                      progressColor: Theme.of(context).colorScheme.primary,
                      isRTL: true,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: SizeUtils.scale(4, size.width)),
                      child: MyText(
                          text: 'Working Progress',
                          style: AppFonts.LabelSmall.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onBackground)),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  hasNoLunchBreak == true
                      ? const SizedBox.shrink()
                      : Expanded(
                          child: isBreakTime == true
                              ? AttendanceButton(
                                  label: 'Resume',
                                  color: Theme.of(context).colorScheme.primary,
                                  onlyBorder: true,
                                  svgIcon: IconAssets.task,
                                )
                              : AttendanceButton(
                                  label: 'Lunch Break',
                                  color: Theme.of(context).colorScheme.primary,
                                  svgIcon: IconAssets.noodle,
                                ),
                        ),
                  SizedBox(
                      width: SizeUtils.scale(
                          hasNoLunchBreak == true ? 0 : 12, size.width)),
                  Expanded(
                    child: AttendanceButton(
                      onTap: () {
                        onCheckOut();
                      },
                      label: 'Check Out',
                      color: MyColor.error,
                      svgIcon: IconAssets.logoutTwoTone,
                    ),
                  )
                ],
              ),
            ],
          )
        : Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => MyText(
                        text: DateUtil.formatTime(currentTime.value),
                        style: AppFonts.HeadlineMedium,
                      )),
                  MyText(
                    text: currentDate,
                    style: AppFonts.BodyXSmall.copyWith(
                        color: const Color(0xFF6b7180)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeUtils.scale(12, size.width)),
                    child: GestureDetector(
                      onTap: disableButton
                          ? null
                          : isDisableButton.value == true
                              ? null
                              : isCheckedIn == true
                                  ? () async {
                                      try {
                                        isDisableButton.value = true;
                                        await onCheckOut();
                                      } catch (e) {
                                        Logs.e(e);
                                        return;
                                      } finally {
                                        isDisableButton.value = false;
                                      }
                                    }
                                  : () async {
                                      try {
                                        isDisableButton.value = true;
                                        await onCheckIn();
                                      } catch (e) {
                                        Logs.e(e);
                                        return;
                                      } finally {
                                        isDisableButton.value = false;
                                      }
                                    },
                      child: ScaleTransition(
                        scale: scale,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: buttonSize ?? SizeUtils.scale(130, size.width),
                          height:
                              buttonSize ?? SizeUtils.scale(130, size.width),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              AppShadow.shadowWithColor(
                                  Theme.of(context).colorScheme.primary)
                            ],
                            gradient: LinearGradient(
                              colors: disableButton
                                  ? [
                                      Theme.of(context).colorScheme.outline,
                                      Theme.of(context).colorScheme.outline,
                                    ]
                                  : isCheckedIn != null
                                      ? isCheckedIn == true
                                          ? [
                                              const Color(0XFFe83371),
                                              const Color(0XFF9b3092),
                                            ]
                                          : Get.isDarkMode
                                              ? [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                      .darken(12),
                                                ]
                                              : [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                      .lighten(12),
                                                ]
                                      : [
                                          const Color.fromARGB(
                                              255, 122, 122, 122),
                                          const Color.fromARGB(
                                              255, 122, 122, 122),
                                        ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              tileMode: TileMode.mirror,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                SvgAssets.tap,
                                width: iconSize ?? size.height * 0.05,
                                height: iconSize ?? size.height * 0.05,
                                colorFilter: ColorFilter.mode(
                                  isCheckedIn == true && Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.onPrimary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(height: AppSize().paddingS4),
                              MyText(
                                text: isCheckedIn == true
                                    ? "Check Out"
                                    : "Check In",
                                style: AppFonts().bodyLargeMedium.copyWith(
                                      color:
                                          isCheckedIn == true && Get.isDarkMode
                                              ? Colors.white
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: SizeUtils.scale(1, size.width)),
                        child: SvgIcon(
                            icon: IconAssets.location,
                            color: Theme.of(context).colorScheme.primary,
                            height: SizeUtils.scale(18, size.width),
                            width: SizeUtils.scale(18, size.width)),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Location: ",
                                style: AppFonts.LabelSmall.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            TextSpan(
                                text: isInOfficeRange
                                    ? "You are in office area."
                                    : "You are not in office area.",
                                style: AppFonts.LabelSmall.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                )),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(SizeUtils.scale(12, size.width)),
                child: Obx(() => MSHCheckbox(
                      value: AppConfig.confirmCheckIn.value,
                      size: SizeUtils.scale(15, size.width),
                      onChanged: (value) async {
                        await IsarService().saveLocalData(
                            input: LocalStorageModel(confirmCheckIn: value));
                        AppConfig.confirmCheckIn.value = value;
                      },
                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                        checkedColor: Theme.of(context).colorScheme.primary,
                        uncheckedColor: Theme.of(context).colorScheme.secondary,
                      ),
                      style: MSHCheckboxStyle.fillScaleColor,
                    )),
              ),
            ],
          );
  }
}
