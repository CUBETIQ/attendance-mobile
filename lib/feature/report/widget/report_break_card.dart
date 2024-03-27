import 'package:flutter/material.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';

class ReportBreakCard extends StatelessWidget {
  const ReportBreakCard({super.key, required this.attendance});

  final AttendanceModel attendance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyCard(
      width: size.width,
      padding: EdgeInsets.symmetric(
        vertical: SizeUtils.scale(12, size.width),
        horizontal: SizeUtils.scale(16, size.width),
      ),
      boxShadow: const [],
      border: Border.all(color: Theme.of(context).colorScheme.primary),
      borderRadius:
          BorderRadius.circular(SizeUtils.scale(AppSpacing.L, size.width)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "Break",
                  style: AppFonts.TitleXSmall.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                MyText(
                  text: "Started",
                  style: AppFonts.LabelSmall.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                MyText(
                  text: "Ended",
                  style: AppFonts.LabelSmall.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ].withDivide(height: SizeUtils.scale(4, size.width)),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "Time",
                  style: AppFonts.TitleXSmall.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                MyText(
                  text: DateUtil.formatTimeWithDate(
                    attendance.breakTime?.start,
                  ),
                  style: AppFonts.LabelSmall.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                MyText(
                  text: DateUtil.formatTimeWithDate(
                    attendance.breakTime?.end,
                  ),
                  style: AppFonts.LabelSmall.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ].withDivide(height: SizeUtils.scale(4, size.width)),
            ),
          ),
        ],
      ),
    );
  }
}
