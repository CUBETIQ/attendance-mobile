import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/admin_leave_report_model.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/date_util.dart';

class LeaveDataRowReport extends StatelessWidget {
  const LeaveDataRowReport({super.key, required this.leave});

  final LeaveReportModel? leave;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: SizeUtils.scale(30, size.width),
              height: SizeUtils.scale(30, size.width),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Icon(
                Icons.calendar_today,
                color: Theme.of(context).colorScheme.onPrimary,
                size: SizeUtils.scale(18, size.width),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 255,
              ),
              child: MyText(
                text: "${leave?.type.capitalizeMaybeNull ?? ""} Leave",
                style: AppFonts().bodyMediumMedium,
              ),
            ),
            const Spacer(),
            MyText(
              text: "Duration: ${leave?.duration ?? 0}",
              style: AppFonts().bodyMediumMedium,
            ),
            MyText(
              text: (leave?.duration ?? 0) > 1 ? " days" : " day",
              style: AppFonts().bodyMediumMedium,
            ),
          ],
        ),
        SizedBox(height: SizeUtils.scale(5, size.width)),
        MyText(
          text:
              "From: ${DateUtil.formatMillisecondsToDOB(leave?.from)} - ${DateUtil.formatMillisecondsToDOB(leave?.to)}",
          style: AppFonts().bodySmallRegular,
        ),
      ],
    );
  }
}
