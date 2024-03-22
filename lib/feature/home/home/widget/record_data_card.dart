import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/check_box/check_box.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/home/home/widget/status_card.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';

class RecordDataCard extends StatelessWidget {
  final int? time;
  final String? timeString;
  final String svgIcon;
  final String statusTitle;
  final String onNullTitle;
  final String secondTitle;
  final String? status;
  final Color? iconColor;
  final bool? noStatus;
  final bool? isBreakTime;
  final String? breakTimeTitle;
  final bool? isCheckOut;
  final String? statusLabel;

  const RecordDataCard({
    super.key,
    this.time,
    required this.svgIcon,
    required this.statusTitle,
    required this.onNullTitle,
    required this.secondTitle,
    this.status,
    this.timeString,
    this.iconColor,
    this.noStatus,
    this.isBreakTime,
    this.breakTimeTitle,
    this.isCheckOut,
    this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: SizeUtils.scale(12, size.width)),
              child: MyCheckBox(
                hasNoBackground: true,
                isChecked: time != null
                    ? true
                    : isBreakTime == true
                        ? true
                        : false,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(bottom: SizeUtils.scale(4, size.width)),
                  child: MyText(
                    text: time != null
                        ? DateUtil.formatTimeNoTrailing(
                            DateTime.fromMillisecondsSinceEpoch(
                            time ?? 0,
                          ))
                        : timeString ?? "--:--",
                    style: AppFonts.LabelMedium.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                MyText(
                  text: time != null ? secondTitle : onNullTitle,
                  style: AppFonts.LabelXSmall.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          constraints: BoxConstraints(
            minWidth: SizeUtils.scale(145, size.width),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                SizeUtils.scale(AppSize().borderRadiusMedium, size.width),
              ),
              color: isBreakTime == true
                  ? null
                  : Theme.of(context).colorScheme.background,
              gradient: isBreakTime == true ? MyColor.gradient01 : null),
          child: Padding(
            padding: EdgeInsets.all(SizeUtils.scale(12, size.width)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeUtils.scale(6, size.width)),
                      child: MyText(
                        text: statusTitle,
                        style: AppFonts.LabelMedium.copyWith(
                          color: isBreakTime == true
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                    StatusCard(
                      status: status,
                      statusLabel: statusLabel,
                      isBreakTime: isBreakTime,
                      breakTimeTitle: breakTimeTitle,
                      isCheckOut: isCheckOut,
                    ),
                  ],
                ),
                SvgIcon(
                  icon: svgIcon,
                  height: SizeUtils.scale(24, size.width),
                  width: SizeUtils.scale(24, size.width),
                  color: isBreakTime == true
                      ? Get.isDarkMode
                          ? Theme.of(context).colorScheme.onBackground
                          : Theme.of(context).colorScheme.onPrimary
                      : Get.isDarkMode
                          ? Theme.of(context).colorScheme.onBackground
                          : null,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
