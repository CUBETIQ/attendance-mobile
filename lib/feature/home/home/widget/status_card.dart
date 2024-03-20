import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/types/attendance_status.dart';
import 'package:timesync/utils/color_utils.dart';
import 'package:timesync/utils/size_util.dart';

class StatusCard extends StatelessWidget {
  final String? status;
  final String? breakTimeTitle;
  final bool? isBreakTime;

  const StatusCard({
    super.key,
    this.status,
    this.breakTimeTitle,
    this.isBreakTime = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isBreakTime == true
        ? MyText(
            text: breakTimeTitle ?? "Ongoing",
            style: AppFonts().bodySmallMedium.copyWith(
                  color: Colors.white,
                ),
          )
        : isBreakTime == false
            ? const SizedBox.shrink()
            : Container(
                height: SizeUtils.scale(25, size.width),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize().paddingS7,
                ),
                decoration: BoxDecoration(
                  color: status != null
                      ? ColorUtil.getStatusColor(status)
                      : Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(
                    AppSize().borderRadiusMedium * (size.width / 375.0),
                  ),
                ),
                child: MyText(
                  text: (status ?? "No Status").capitalizeFirst,
                  style: AppFonts().bodySmallMedium.copyWith(
                        color: status != null
                            ? status == AttendanceStatus.early
                                ? Colors.white
                                : Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              );
  }
}
