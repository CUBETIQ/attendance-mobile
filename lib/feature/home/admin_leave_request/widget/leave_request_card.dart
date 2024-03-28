import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:timesync/constants/app_shadow.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/feature/home/admin_leave_request/widget/small_button.dart';
import 'package:timesync/types/leave.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';
import 'package:timesync/utils/validator.dart';

class LeaveRequestCard extends StatelessWidget {
  const LeaveRequestCard({
    super.key,
    required this.leave,
    this.height,
    this.onTapView,
    required this.staff,
    required this.position,
  });

  final LeaveModel leave;
  final UserModel staff;
  final PositionModel position;
  final double? height;
  final void Function()? onTapView;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.scale(16, size.width),
        vertical: SizeUtils.scale(12, size.width),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.L),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [AppShadow.shadowWithoutColor],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyCacheImage(
                    imageUrl: staff.image,
                    height: SizeUtils.scale(40, size.width),
                    width: SizeUtils.scale(40, size.width),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: SizeUtils.scale(16, size.width)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                            text: StringUtil.getfullname(
                              staff.firstName,
                              staff.lastName,
                              staff.username,
                            ),
                            style: AppFonts.TitleSmall.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground)),
                        Validator.isValNull(position.name)
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.only(
                                    top: SizeUtils.scale(2, size.width)),
                                child: MyText(
                                    text: position.name ?? '',
                                    style: AppFonts.LabelSmall.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground)),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: leave.status == LeaveStatus.pending
                      ? const Color(0XFFBF9705)
                      : leave.status == LeaveStatus.approved
                          ? Colors.green
                          : Colors.red,
                  borderRadius: BorderRadius.circular(AppSpacing.M),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.scale(8, size.width),
                      vertical: SizeUtils.scale(4, size.width)),
                  child: MyText(
                    text: (leave.status ?? LeaveStatus.pending).capitalizeFirst,
                    style: AppFonts().bodySmallRegular.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: SizeUtils.scale(12, size.width)),
            child: Divider(
                height: SizeUtils.scale(1, size.width), color: MyColor.base4),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(right: SizeUtils.scale(16, size.width)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                        text:
                            " ${StringUtil.removeTrailingZeros(leave.duration)}  ${(leave.duration ?? 0) < 2 ? "Day" : "Days"}",
                        style: AppFonts.TitleXSmall.copyWith(
                            color: Theme.of(context).colorScheme.onBackground)),
                    MyText(
                      text:
                          "${DateUtil.formatMillisecondsToDOB(leave.from)} - ${DateUtil.formatMillisecondsToDOB(leave.to)}",
                      style: AppFonts.LabelMedium.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    MyText(
                      text:
                          "${(leave.type ?? LeaveType.annual).capitalizeAllWordsFirstLetter()} Leave",
                      style: AppFonts.TitleXSmall.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ].withSpaceBetween(
                    height: SizeUtils.scale(4, size.width),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeUtils.scale(4, size.width)),
                      child: MyText(
                        text: leave.status == LeaveStatus.approved
                            ? "Approved By"
                            : leave.status == LeaveStatus.rejected
                                ? "Declined By"
                                : "Pending",
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.LabelMedium.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                    MyText(
                      text: StringUtil.getfullname(
                        leave.updateBy?.firstName,
                        leave.updateBy?.lastName,
                        leave.updateBy?.username,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.end,
                      style: AppFonts.TitleXSmall.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeUtils.scale(12, size.width)),
            child: SmallButton(
              title: "View Details",
              textStyle: AppFonts.TitleSmall.copyWith(color: Colors.white),
              size: size,
              onTap: onTapView,
              backgroundColor: leave.status == LeaveStatus.pending
                  ? Theme.of(context).colorScheme.primary
                  : MyColor.secondaryText,
            ),
          )
        ],
      ),
    );
  }
}
