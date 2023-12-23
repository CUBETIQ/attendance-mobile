import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/leave_model.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/time_formater.dart';
import 'package:attendance_app/utils/types_helper/leave_status.dart';
import 'package:attendance_app/utils/types_helper/leave_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class LeaveCard extends StatelessWidget {
  final LeaveModel leave;
  final void Function()? onTap;

  const LeaveCard({super.key, required this.leave, this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 170 * (size.width / 375),
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
                    color: leave.leaveStatus == LeaveStatus.pending
                        ? const Color(0XFFBF9705)
                        : leave.leaveStatus == LeaveStatus.approved
                            ? Colors.green
                            : Colors.red,
                    borderRadius: BorderRadius.circular(
                      10 * (size.width / 375.0),
                    ),
                  ),
                  child: MyText(
                    text: (leave.leaveStatus ?? LeaveStatus.pending)
                            .capitalizeFirst ??
                        LeaveStatus.pending,
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
                      "${(leave.leaveType ?? LeaveType.annual).capitalize} leave request",
                  style: BodyLargeMedium,
                ),
                MyText(
                  text:
                      "${DateFormatter().formatMillisecondsToDOB(leave.leaveFrom)} - ${DateFormatter().formatMillisecondsToDOB(leave.leaveTo)}",
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
                )
              ],
            ),
            SizedBox(
              width: 85 * (size.width / 375.0),
              height: 35 * (size.width / 375.0),
              child: MyButton(
                backgroundColor: Theme.of(context).colorScheme.outline,
                title: "Cancel",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
