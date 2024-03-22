import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/color_utils.dart';
import 'package:timesync/utils/size_util.dart';

class StatusCard extends StatelessWidget {
  final String? status;
  final String? statusLabel;
  final String? breakTimeTitle;
  final bool? isBreakTime;
  final bool? isCheckOut;
  final String? checkOut;

  const StatusCard({
    super.key,
    this.status,
    this.statusLabel,
    this.breakTimeTitle,
    this.isBreakTime = false,
    this.isCheckOut = false,
    this.checkOut,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isBreakTime == true
        ? MyText(
            text: breakTimeTitle ?? "Ongoing",
            style: AppFonts.LabelXSmall.copyWith(color: Colors.white),
          )
        : isBreakTime == false || status == null
            ? MyText(
                text: isCheckOut == true ? "-" : "Not Started",
                style: AppFonts.LabelXSmall.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              )
            : Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: status != null
                      ? ColorUtil.getStatusColor(context, status,
                          isCheckOut: isCheckOut)
                      : Theme.of(context).colorScheme.outline.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(
                    SizeUtils.scale(AppSize().borderRadiusMedium, size.width),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.scale(8, size.width),
                      vertical: SizeUtils.scale(4, size.width)),
                  child: MyText(
                    text: (statusLabel ?? "Not Started").capitalizeFirst,
                    style: AppFonts.LabelXSmall.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              );
  }
}
