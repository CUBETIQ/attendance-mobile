import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/leave_model.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/string_util.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:timesync360/types/leave_status.dart';
import 'package:timesync360/types/leave_type.dart';
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
      onTap: leave.status != LeaveStatus.pending ? null : onTap,
      child: Container(
        height: SizeUtils.scale(170, size.width),
        margin:
            EdgeInsets.only(bottom: AppSize().paddingS8 * (size.width / 375.0)),
        padding: EdgeInsets.symmetric(
          horizontal:
              SizeUtils.scale(AppSize().paddingHorizontalLarge, size.width),
          vertical:
              SizeUtils.scale(AppSize().paddingVerticalMedium, size.width),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize().borderRadiusMedium * (size.width / 375.0),
          ),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1.5,
              blurRadius: 1.5,
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
                        AppSize().paddingHorizontalSmall * (size.width / 375.0),
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
                    style: AppStyles().bodySmallRegular.copyWith(
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
                  style: AppStyles().bodyLargeMedium,
                ),
                MyText(
                  text:
                      "${DateFormatter.formatMillisecondsToDOB(leave.from)} - ${DateFormatter.formatMillisecondsToDOB(leave.to)}",
                  style: AppStyles().bodySmallRegular.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                Row(
                  children: [
                    MyText(
                      text: "Duration: ",
                      style: AppStyles().bodySmallRegular.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                    MyText(
                      text:
                          " ${StringUtil.removeTrailingZeros(leave.duration)}  ",
                      style: AppStyles().bodySmallRegular.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: leave.status == LeaveStatus.approved
                          ? "Approved By"
                          : leave.status == LeaveStatus.rejected
                              ? "Declined By"
                              : "Pending Approval",
                      style: AppStyles().bodySmallRegular.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                    SizedBox(
                      height: 5 * (size.width / 375.0),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: SizeUtils.scale(160, size.width),
                      ),
                      child: MyText(
                        text: StringUtil.getfullname(
                          leave.updateBy?.firstName,
                          leave.updateBy?.lastName,
                          leave.updateBy?.username,
                        ),
                        style: AppStyles().bodyMediumRegular.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
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
                leave.status == LeaveStatus.pending
                    ? GestureDetector(
                        onTap: onTapCancel,
                        child: Container(
                          width: SizeUtils.scale(100, size.width),
                          height: SizeUtils.scale(30, size.width),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppSize().borderRadiusMedium *
                                  (size.width / 375.0),
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
                            style: AppStyles().bodySmallMedium,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                leave.status == LeaveStatus.pending
                    ? SizedBox(
                        height:
                            SizeUtils.scale(AppSize().paddingS4, size.width),
                      )
                    : const SizedBox.shrink(),
                GestureDetector(
                  onTap: onTapView,
                  child: Container(
                    width: SizeUtils.scale(100, size.width),
                    height: SizeUtils.scale(30, size.width),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSize().borderRadiusMedium * (size.width / 375.0),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: MyText(
                      text: "View",
                      style: AppStyles().bodySmallMedium.copyWith(
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
