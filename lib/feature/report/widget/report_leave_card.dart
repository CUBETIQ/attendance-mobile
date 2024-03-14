import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/text.dart';
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
      height: SizeUtils.scale(75, size.width),
      padding: EdgeInsets.only(
        right: SizeUtils.scale(20, size.width),
      ),
      borderRadius: BorderRadius.circular(
        SizeUtils.scale(
          14,
          size.width,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: SizeUtils.scale(35, size.width),
            height: SizeUtils.scale(75, size.width),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  SizeUtils.scale(
                    14,
                    size.width,
                  ),
                ),
                bottomLeft: Radius.circular(
                  SizeUtils.scale(
                    14,
                    size.width,
                  ),
                ),
              ),
              color: Colors.orange,
            ),
          ),
          SizedBox(
            width: SizeUtils.scale(15, size.width),
          ),
          Expanded(
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
                          style: AppFonts().bodyMediumSemi,
                        ),
                        MyText(
                          text: DateUtil.formatMillisecondsToDOB(leave.from),
                          style: AppFonts().bodySmallRegular,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          text: "To",
                          style: AppFonts().bodyMediumSemi,
                        ),
                        MyText(
                          text: DateUtil.formatMillisecondsToDOB(leave.to),
                          style: AppFonts().bodySmallRegular,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyText(
                          text: "Status",
                          style: AppFonts().bodyMediumSemi,
                        ),
                        MyText(
                          text: leave.status?.capitalizeFirst ?? "N/A",
                          style: AppFonts().bodySmallSemi.copyWith(
                                color: Colors.green,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        MyText(
                          text: "Type: ",
                          style: AppFonts().bodySmallMedium,
                        ),
                        MyText(
                          text: leave.type?.capitalizeFirst ?? "N/A",
                          style: AppFonts().bodySmallMedium.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyText(
                          text: "Approver: ",
                          style: AppFonts().bodySmallMedium,
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: SizeUtils.scale(100, size.width),
                          ),
                          child: MyText(
                            text: StringUtil.getfullname(
                              leave.updateBy?.firstName,
                              leave.updateBy?.lastName,
                              leave.updateBy?.username,
                            ),
                            overflow: TextOverflow.ellipsis,
                            style: AppFonts().bodySmallMedium.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
