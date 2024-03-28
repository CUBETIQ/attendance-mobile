import 'package:flutter/material.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/leave/leave/widget/leave_status_card.dart';
import 'package:timesync/types/leave.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';

class LeaveCard extends StatelessWidget {
  final LeaveModel leave;
  final void Function()? onTap;
  final double? width;
  final double? height;

  const LeaveCard({
    super.key,
    required this.leave,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: leave.status != LeaveStatus.pending ? null : onTap,
      child: Container(
        width: size.width,
        padding: EdgeInsets.all(
          SizeUtils.scale(12, size.width),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeUtils.scale(AppSpacing.L, size.width),
          ),
          color: Theme.of(context).colorScheme.background,
          border: Border.all(
            color: MyColor.base4,
            width: SizeUtils.scale(1, size.width),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: DateUtil.getApplicationDuration(leave.duration),
                  style: AppFonts.TitleXSmall.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const LeaveStatusCard(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
