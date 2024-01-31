import 'package:timesync360/config/font.dart';
import 'package:timesync360/core/model/leave_model.dart';
import 'package:timesync360/core/widgets/card/my_card.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
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
                          style: BodyMediumSemi,
                        ),
                        SizedBox(height: SizeUtils.scale(2, size.width)),
                        MyText(
                          text: DateFormatter()
                              .formatMillisecondsToDOB(leave.from),
                          style: BodySmallRegular,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          text: "To",
                          style: BodyMediumSemi,
                        ),
                        SizedBox(height: SizeUtils.scale(2, size.width)),
                        MyText(
                          text:
                              DateFormatter().formatMillisecondsToDOB(leave.to),
                          style: BodySmallRegular,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          text: "Status",
                          style: BodyMediumSemi,
                        ),
                        SizedBox(height: SizeUtils.scale(2, size.width)),
                        MyText(
                          text: leave.status?.capitalizeFirst ?? "N/A",
                          style: BodySmallSemi.copyWith(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: SizeUtils.scale(5, size.width)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        MyText(
                          text: "Type: ",
                          style: BodySmallMedium,
                        ),
                        MyText(
                          text: leave.type?.capitalizeFirst ?? "N/A",
                          style: BodySmallMedium.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyText(
                          text: "Approver: ",
                          style: BodySmallMedium,
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: SizeUtils.scale(100, size.width),
                          ),
                          child: MyText(
                            text: leave.updateBy?["name"] ?? "N/A",
                            overflow: TextOverflow.ellipsis,
                            style: BodySmallMedium.copyWith(
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
