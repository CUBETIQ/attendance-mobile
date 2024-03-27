import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportLeaveCard extends StatelessWidget {
  const ReportLeaveCard({super.key, required this.leave});

  final LeaveModel leave;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: "From",
                    style: AppFonts.TitleXSmall.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  MyText(
                    text: DateUtil.formatMillisecondsToDOB(leave.from),
                    style: AppFonts.LabelSmall.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  MyText(
                    text: DateUtil.formatTimeWithDate(leave.from),
                    style: AppFonts.LabelSmall.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ].withDivide(height: SizeUtils.scale(4, size.width)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: "To",
                    style: AppFonts.TitleXSmall.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  MyText(
                    text: DateUtil.formatMillisecondsToDOB(leave.to),
                    style: AppFonts.LabelSmall.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  MyText(
                    text: DateUtil.formatTimeWithDate(leave.to),
                    style: AppFonts.LabelSmall.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ].withDivide(height: SizeUtils.scale(4, size.width)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: "Status",
                    style: AppFonts.TitleXSmall.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  MyText(
                    text: leave.status?.capitalizeFirst ?? "N/A",
                    style: AppFonts.LabelSmall.copyWith(
                      color: Colors.green,
                    ),
                  ),
                  MyText(
                    text: "",
                    style: AppFonts.LabelSmall.copyWith(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
