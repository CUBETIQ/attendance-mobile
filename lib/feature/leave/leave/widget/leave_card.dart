import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/leave_model.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_formater.dart';
import 'package:attendance_app/utils/types_helper/leave_duration_type.dart';
import 'package:attendance_app/utils/types_helper/leave_status.dart';
import 'package:attendance_app/utils/types_helper/leave_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class LeaveCard extends StatelessWidget {
  final LeaveModel leave;
  final void Function()? onTap;
  final void Function()? onTapCancel;
  final void Function()? onTapView;

  const LeaveCard({
    super.key,
    required this.leave,
    this.onTap,
    this.onTapCancel,
    this.onTapView,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeUtils.scaleWidth(170, size.width),
        margin:
            EdgeInsets.only(bottom: AppSize.paddingS5 * (size.width / 375.0)),
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.paddingHorizontalLarge * (size.width / 375.0),
          vertical: AppSize.paddingVerticalLarge * (size.width / 375.0),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.borderRadiusMedium * (size.width / 375.0),
          ),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 4,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20 * (size.width / 375.0),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        AppSize.paddingHorizontalSmall * (size.width / 375.0),
                  ),
                  decoration: BoxDecoration(
                    color: leave.status == LeaveStatus.pending
                        ? const Color(0XFFBF9705)
                        : leave.status == LeaveStatus.approved
                            ? Colors.green
                            : Colors.red,
                    borderRadius: BorderRadius.circular(
                      10 * (size.width / 375.0),
                    ),
                  ),
                  child: MyText(
                    text: (leave.status ?? LeaveStatus.pending).capitalizeFirst,
                    style: BodySmallRegular.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10 * (size.width / 375.0),
                ),
                MyText(
                  text:
                      "${(leave.type ?? LeaveType.annual).capitalize} leave request",
                  style: BodyLargeMedium,
                ),
                MyText(
                  text:
                      "${DateFormatter().formatMillisecondsToDOB(leave.from)} - ${DateFormatter().formatMillisecondsToDOB(leave.to)}",
                  style: BodySmallRegular.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    MyText(
                      text: "Pending Approval",
                      style: BodySmallRegular.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    SizedBox(
                      height: 5 * (size.width / 375.0),
                    ),
                    MyText(
                      text: leave.updateBy != null ? leave.updateBy! : "-----",
                      style: BodyMediumRegular.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    MyText(
                      text: "Duration: ",
                      style: BodySmallRegular.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    MyText(
                      text: (leave.duration ?? 0) <= 1440
                          ? leave.durationType == LeaveTypeDuration.fullDay
                              ? "1 day"
                              : "0.5 day"
                          : DateFormatter()
                              .formatMinutesToDays(leave.duration ?? 0),
                      style: BodySmallRegular.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onTapCancel,
                  child: Container(
                    width: SizeUtils.scaleWidth(100, size.width),
                    height: SizeUtils.scaleWidth(30, size.width),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSize.borderRadiusMedium * (size.width / 375.0),
                      ),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .error
                            .withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    child: MyText(
                      text: "Cancel",
                      style: BodySmallMedium,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onTapView,
                  child: Container(
                    width: SizeUtils.scaleWidth(100, size.width),
                    height: SizeUtils.scaleWidth(30, size.width),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSize.borderRadiusMedium * (size.width / 375.0),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: MyText(
                      text: "View",
                      style: BodySmallMedium.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
