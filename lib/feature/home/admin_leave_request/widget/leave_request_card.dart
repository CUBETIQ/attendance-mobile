import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/leave_model.dart';
import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/home/admin_leave_request/widget/small_button.dart';
import 'package:timesync360/feature/home/admin_leave_request/widget/small_outline_button.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/string_util.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:timesync360/types/leave_status.dart';
import 'package:timesync360/types/leave_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import '../../../../constants/app_size.dart';

class LeaveRequestCard extends StatelessWidget {
  const LeaveRequestCard({
    super.key,
    required this.leave,
    this.height,
    this.onTapView,
    required this.staff,
    this.onTapApprove,
    this.onTapDecline,
  });

  final LeaveModel leave;
  final UserModel staff;
  final double? height;
  final void Function()? onTapView;
  final void Function()? onTapApprove;
  final void Function()? onTapDecline;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: AppSize.paddingS4 * (size.width / 375.0)),
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.scale(AppSize.paddingHorizontalLarge, size.width),
        vertical: SizeUtils.scale(AppSize.paddingVerticalMedium, size.width),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeUtils.scale(AppSize.borderRadiusLarge, size.width),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MyCacheImage(imageUrl: staff.image),
                  SizedBox(width: SizeUtils.scale(10, size.width)),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: SizeUtils.scale(130, size.width),
                    ),
                    child: MyText(
                      text: StringUtil().getfullname(
                        staff.firstName,
                        staff.lastName,
                        staff.username,
                      ),
                      style: BodyMediumRegular,
                    ),
                  ),
                ],
              ),
              Container(
                height: 20 * (size.width / 375.0),
                width: 80 * (size.width / 375.0),
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
            ],
          ),
          SizedBox(
            height: 10 * (size.width / 375.0),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Row(
                    children: [
                      MyText(
                        text: "Duration: ",
                        style: BodySmallRegular.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      MyText(
                        text:
                            " ${StringUtil().removeTrailingZeros(leave.duration)}  ${(leave.duration ?? 0) < 2 ? "Day" : "Days"}",
                        style: BodySmallRegular.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ],
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
                    style: BodySmallRegular.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  SizedBox(height: SizeUtils.scale(5, size.width)),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: SizeUtils.scale(90, size.width),
                    ),
                    child: MyText(
                      text: leave.updateBy?["name"] ?? "-----",
                      maxLines: 2,
                      style: BodyMediumRegular.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: SizeUtils.scale(10, size.width)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              leave.status == LeaveStatus.pending
                  ? Expanded(
                      child: SmallButton(
                        size: size,
                        title: "Approve",
                        onTap: onTapApprove,
                      ),
                    )
                  : const SizedBox.shrink(),
              leave.status == LeaveStatus.pending
                  ? SizedBox(
                      width: SizeUtils.scale(5, size.width),
                    )
                  : const SizedBox.shrink(),
              leave.status == LeaveStatus.pending
                  ? Expanded(
                      child: SmallOutlineButton(
                        title: "Decline",
                        size: size,
                        onTap: onTapDecline,
                      ),
                    )
                  : const SizedBox.shrink(),
              leave.status == LeaveStatus.pending
                  ? SizedBox(
                      width: SizeUtils.scale(5, size.width),
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: SmallButton(
                  title: "View",
                  size: size,
                  onTap: onTapView,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
