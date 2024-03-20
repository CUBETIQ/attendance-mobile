import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/home/home/widget/attendance_info_widget.dart';
import 'package:timesync/utils/size_util.dart';
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
    final customChartRadius = SizeUtils.scale(34, size.width);
    return MyCard(
      width: cardWidth ?? size.width,
      height: cardHeight ?? SizeUtils.scale(150, size.width),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: SizeUtils.scale(20, size.width)),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: cardWidth ?? SizeUtils.scale(120, size.width),
                height: cardHeight ?? SizeUtils.scale(120, size.width),
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
                          sectionsSpace: 0,
                          sections: [
                            PieChartSectionData(
                              showTitle: false,
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                              value: 100,
                              title: "No Data",
                              radius: chartRadius ??
                                  SizeUtils.scale(59, size.width),
                              titleStyle: AppFonts().bodyMediumRegular.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        )
                      : PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: SizeUtils.scale(28, size.width),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sections: [
                            PieChartSectionData(
                              showTitle: false,
                              color: MyColor.successColor,
                              value: presentPercentage ?? 0,
                              title: "Present",
                              radius: chartRadius ?? customChartRadius,
                              titleStyle: AppFonts().bodyMediumRegular.copyWith(
                                    color: Colors.white,
                                  ),
                              badgeWidget: _Badge(
                                percentage: presentPercentage,
                                color: MyColor.successColor,
                              ),
                              badgePositionPercentageOffset: .98,
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              color: MyColor.pendingColor,
                              value: onLeavePercentage ?? 0,
                              title: "On Leave",
                              radius: chartRadius ?? customChartRadius,
                              titleStyle: AppFonts().bodyMediumRegular.copyWith(
                                    color: Colors.white,
                                  ),
                              badgeWidget: _Badge(
                                percentage: onLeavePercentage,
                                color: MyColor.pendingColor,
                              ),
                              badgePositionPercentageOffset: .98,
                            ),
                            PieChartSectionData(
                              showTitle: false,
                              color: MyColor.errorColor,
                              value: absentPercentage ?? 0,
                              title: "Absent",
                              radius: chartRadius ?? customChartRadius,
                              titleStyle: AppFonts().bodyMediumRegular.copyWith(
                                    color: Colors.white,
                                  ),
                              badgeWidget: _Badge(
                                percentage: absentPercentage,
                                color: MyColor.errorColor,
                              ),
                              badgePositionPercentageOffset: .98,
                            ),
                          ],
                        ),
                  swapAnimationDuration: const Duration(milliseconds: 150),
                  swapAnimationCurve: Curves.linear,
                ),
              ),
            ),
          ),
          SizedBox(width: SizeUtils.scale(20, size.width)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(text: "Summary", style: AppFonts().bodyLargeMedium),
              AttendanceInfoWidget(
                color: MyColor.successColor,
                title: "Present: ",
                value: totalPresent,
              ),
              AttendanceInfoWidget(
                color: MyColor.pendingColor,
                title: "Leave: ",
                value: totalOnLeave,
              ),
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

class _Badge extends StatelessWidget {
  const _Badge({this.percentage, this.color});

  final double? percentage;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white.withOpacity(0.7),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeUtils.scale(2, size.width),
              horizontal: SizeUtils.scale(6, size.width)),
          child: MyText(
            text: '${percentage ?? 0}%',
            style: AppFonts().bodySmallRegular.copyWith(
                  color: color ?? Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
      ),
    );
  }
}
