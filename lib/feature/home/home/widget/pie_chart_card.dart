import 'package:timesync360/config/font.dart';
import 'package:timesync360/constants/color.dart';
import 'package:timesync360/core/widgets/card/my_card.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/home/home/widget/attendance_info_widget.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AttendancePieChartCard extends StatelessWidget {
  final double? cardWidth;
  final double? cardHeight;
  final double? chartWidth;
  final double? chartHeight;
  final double? presentPercentage;
  final double? absentPercentage;
  final double? onLeavePercentage;
  final int? totalPresent;
  final int? totalAbsent;
  final int? totalOnLeave;
  final double? chartRadius;
  final bool haveNoData;
  final void Function()? onTap;

  const AttendancePieChartCard({
    super.key,
    this.cardWidth,
    this.cardHeight,
    this.chartWidth,
    this.chartHeight,
    this.presentPercentage,
    this.absentPercentage,
    this.onLeavePercentage,
    this.chartRadius,
    this.totalPresent,
    this.totalAbsent,
    this.totalOnLeave,
    this.onTap,
    this.haveNoData = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyCard(
      width: cardWidth ?? size.width,
      height: cardHeight ?? SizeUtils.scale(150, size.width),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: cardWidth ?? SizeUtils.scale(150, size.width),
              height: cardHeight ?? SizeUtils.scale(150, size.width),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: PieChart(
                haveNoData == true
                    ? PieChartData(
                        sections: [
                          PieChartSectionData(
                            showTitle: false,
                            color: Theme.of(context).colorScheme.outlineVariant,
                            value: 100,
                            title: "No Data",
                            radius:
                                chartRadius ?? SizeUtils.scale(59, size.width),
                            titleStyle: BodyMediumRegular.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sections: [
                          PieChartSectionData(
                            showTitle: false,
                            color: MyColor.successColor,
                            value: presentPercentage ?? 0,
                            title: "Present",
                            radius:
                                chartRadius ?? SizeUtils.scale(59, size.width),
                            titleStyle: BodyMediumRegular.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            showTitle: false,
                            color: MyColor.pendingColor,
                            value: onLeavePercentage ?? 0,
                            title: "On Leave",
                            radius:
                                chartRadius ?? SizeUtils.scale(59, size.width),
                            titleStyle: BodyMediumRegular.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            showTitle: false,
                            color: MyColor.errorColor,
                            value: absentPercentage ?? 0,
                            title: "Absent",
                            radius:
                                chartRadius ?? SizeUtils.scale(59, size.width),
                            titleStyle: BodyMediumRegular.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                swapAnimationDuration: const Duration(milliseconds: 150),
                swapAnimationCurve: Curves.linear,
              ),
            ),
          ),
          SizedBox(width: SizeUtils.scale(30, size.width)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(text: "Summary ", style: BodyLargeMedium),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              AttendanceInfoWidget(
                color: MyColor.successColor,
                title: "Present: ",
                value: totalPresent,
              ),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              AttendanceInfoWidget(
                color: MyColor.pendingColor,
                title: "Leave: ",
                value: totalOnLeave,
              ),
              SizedBox(height: SizeUtils.scale(10, size.width)),
              AttendanceInfoWidget(
                color: MyColor.errorColor,
                title: "Absent: ",
                value: totalAbsent,
              ),
            ],
          )
        ],
      ),
    );
  }
}
