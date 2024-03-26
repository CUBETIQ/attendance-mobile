import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';
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
      border: Border.all(
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
      borderRadius: BorderRadius.circular(AppSize().borderRadiusLarge),
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
                ].withDivide(height: SizeUtils.scale(4, size.width)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeUtils.scale(4, size.width)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: SizeUtils.scale(4, size.width)),
                  child: SizedBox(
                    child: Row(
                      children: [
                        MyText(
                          text: "Type: ",
                          style: AppFonts.LabelSmall.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                        MyText(
                          text: leave.type?.capitalizeFirst ?? "N/A",
                          style: AppFonts.LabelSmall.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyText(
                        text: "Approver: ",
                        style: AppFonts.LabelSmall.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      Flexible(
                        child: MyText(
                          text: StringUtil.getfullname(
                            leave.updateBy?.firstName,
                            leave.updateBy?.lastName,
                            leave.updateBy?.username,
                          ),
                          overflow: TextOverflow.ellipsis,
                          style: AppFonts.LabelSmall.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
