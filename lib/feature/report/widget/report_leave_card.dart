import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/leave_model.dart';
import 'package:timesync360/core/widgets/card/my_card.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/string_util.dart';
import 'package:timesync360/utils/time_util.dart';
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
      height: SizeUtils.scaleMobile(75, size.width),
      padding: EdgeInsets.only(
        right: SizeUtils.scaleMobile(20, size.width),
      ),
      borderRadius: BorderRadius.circular(
        SizeUtils.scaleMobile(
          14,
          size.width,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: SizeUtils.scaleMobile(35, size.width),
            height: SizeUtils.scaleMobile(75, size.width),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  SizeUtils.scaleMobile(
                    14,
                    size.width,
                  ),
                ),
                bottomLeft: Radius.circular(
                  SizeUtils.scaleMobile(
                    14,
                    size.width,
                  ),
                ),
              ),
              color: Colors.orange,
            ),
          ),
          SizedBox(
            width: SizeUtils.scaleMobile(15, size.width),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                        SizedBox(height: SizeUtils.scaleMobile(2, size.width)),
                        MyText(
                          text:
                              DateFormatter.formatMillisecondsToDOB(leave.from),
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
                        SizedBox(height: SizeUtils.scaleMobile(2, size.width)),
                        MyText(
                          text: DateFormatter.formatMillisecondsToDOB(leave.to),
                          style: AppFonts().bodySmallRegular,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          text: "Status",
                          style: AppFonts().bodyMediumSemi,
                        ),
                        SizedBox(height: SizeUtils.scaleMobile(2, size.width)),
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
                SizedBox(height: SizeUtils.scaleMobile(5, size.width)),
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
                            maxWidth: SizeUtils.scaleMobile(100, size.width),
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
