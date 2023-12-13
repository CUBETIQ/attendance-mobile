import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/color.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/types_helper/attendance_status.dart';
import 'package:flutter/material.dart';

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
            style: BodySmallMedium.copyWith(
              color: Colors.white,
            ),
          )
        : isBreakTime == false
            ? const SizedBox.shrink()
            : Container(
                height: size.width * 0.045,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.paddingS7,
                ),
                decoration: BoxDecoration(
                  color: status != null
                      ? status == AttendanceStatus.early
                          ? const Color(MyColor.success)
                          : status == AttendanceStatus.late
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(
                    AppSize.borderRadiusMedium * (size.width / 375.0),
                  ),
                ),
                child: MyText(
                  text: status ?? "No Status",
                  style: BodySmallMedium.copyWith(
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
