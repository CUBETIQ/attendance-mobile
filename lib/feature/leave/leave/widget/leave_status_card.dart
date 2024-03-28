import 'package:flutter/material.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/color_utils.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

class LeaveStatusCard extends StatelessWidget {
  const LeaveStatusCard({super.key, this.status});

  final String? status;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.scale(8, size.width),
        vertical: SizeUtils.scale(4, size.width),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeUtils.scale(AppSpacing.M, size.width),
        ),
        color: ColorUtil.getStatusColorByLeaveStatus(
          context,
          status,
        ),
      ),
      child: MyText(
        text: StringUtil.leaveStatusSimplify(status),
        style: AppFonts.LabelSmall.copyWith(
          color: ColorUtil.getTextColorByLeaveStatus(
            context,
            status,
          ),
        ),
      ),
    );
  }
}
