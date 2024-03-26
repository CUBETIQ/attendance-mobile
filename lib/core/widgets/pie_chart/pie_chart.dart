import 'package:fl_chart/fl_chart.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/feature/home/home/widget/attendance_info_widget.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

class MyPieChart extends StatelessWidget {
  final double? cardWidth;
  final double? cardHeight;
  final double? chartWidth;
  final double? chartHeight;
  final double? firstPercentage;
  final double? secondPercentage;
  final double? thirdPercentage;
  final String? firstTitle;
  final String? secondTitle;
  final String? thirdTitle;
  final Color? firstColor;
  final Color? secondColor;
  final Color? thirdColor;
  final double? chartRadius;
  final bool haveNoData;
  final void Function()? onTap;

  const MyPieChart({
    super.key,
    this.cardWidth,
    this.cardHeight,
    this.chartWidth,
    this.chartHeight,
    this.firstPercentage,
    this.secondPercentage,
    this.thirdPercentage,
    this.firstColor,
    this.secondColor,
    this.thirdColor,
    this.firstTitle,
    this.secondTitle,
    this.thirdTitle,
    this.chartRadius,
    this.onTap,
    this.haveNoData = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final customChartRadius = SizeUtils.scale(34, size.width);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: size.width > 600
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: cardWidth ?? SizeUtils.scale(120, size.width),
              height: cardHeight ?? SizeUtils.scale(120, size.width),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.background,
              ),
              child: PieChart(
                haveNoData == true
                    ? PieChartData(
                        sectionsSpace: 0,
                        sections: [
                          PieChartSectionData(
                            showTitle: false,
                            color: MyColor.base4,
                            value: 100,
                            title: "No Data",
                            radius: chartRadius ?? customChartRadius,
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
                            color: firstColor ??
                                Theme.of(context).colorScheme.primary,
                            value: firstPercentage ?? 0,
                            title: firstTitle ?? "Present",
                            radius: chartRadius ?? customChartRadius,
                            titleStyle: AppFonts.TitleXXSmall.copyWith(
                              color: Colors.white,
                            ),
                            badgeWidget: _Badge(
                              percentage: firstPercentage,
                              color: firstColor?.darken(30) ??
                                  Theme.of(context).colorScheme.primary,
                            ),
                            badgePositionPercentageOffset: .70,
                          ),
                          PieChartSectionData(
                            showTitle: false,
                            color: secondColor ??
                                Theme.of(context).colorScheme.secondary,
                            value: secondPercentage ?? 0,
                            title: secondTitle ?? "Leave",
                            radius: chartRadius ?? customChartRadius,
                            titleStyle: AppFonts.TitleXXSmall.copyWith(
                              color: Colors.white,
                            ),
                            badgeWidget: _Badge(
                              percentage: secondPercentage,
                              color: secondColor ??
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            badgePositionPercentageOffset: .70,
                          ),
                          PieChartSectionData(
                            showTitle: false,
                            color: thirdColor ??
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                            value: thirdPercentage ?? 0,
                            title: thirdTitle ?? "Absent",
                            radius: chartRadius ?? customChartRadius,
                            titleStyle: AppFonts.TitleXXSmall.copyWith(
                              color: Colors.white,
                            ),
                            badgeWidget: _Badge(
                              percentage: thirdPercentage,
                              color: thirdColor ??
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                            ),
                            badgePositionPercentageOffset: .70,
                          ),
                        ],
                      ),
                swapAnimationDuration: const Duration(milliseconds: 150),
                swapAnimationCurve: Curves.linear,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width > 600 ? SizeUtils.scale(28.5, size.width) : 0,
                right: SizeUtils.scale(36, size.width),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(text: "Summary", style: AppFonts.TitleMedium),
                  AttendanceInfoWidget(
                    color: firstColor ?? Theme.of(context).colorScheme.primary,
                    title: firstTitle ?? "Present",
                  ),
                  secondTitle == null
                      ? const SizedBox.shrink()
                      : AttendanceInfoWidget(
                          color: secondColor ??
                              Theme.of(context).colorScheme.secondary,
                          title: secondTitle ?? "Leave",
                        ),
                  AttendanceInfoWidget(
                    color: thirdColor ??
                        Theme.of(context).colorScheme.secondaryContainer,
                    title: thirdTitle ?? "Absent",
                  ),
                ].withSpaceBetweenNoSizedBox(
                  height: SizeUtils.scale(8, size.width),
                ),
              ),
            )
          ],
        ),
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
    return Container(
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
          text: StringUtil.doubleToPercentageString(percentage ?? 0),
          style: AppFonts.TitleXXSmall.copyWith(
            color: color ?? Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
