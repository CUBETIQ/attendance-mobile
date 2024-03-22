import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LinearIndicator extends StatelessWidget {
  const LinearIndicator({
    super.key,
    this.percent,
    this.indicatorHeight,
    this.color,
    this.title,
    this.checkInEmployees = 0,
    this.checkOutEmployees = 0,
    this.totalEmployees = 0,
    this.isCheckIn = true,
  });

  final String? title;
  final double? percent;
  final double? indicatorHeight;
  final Color? color;
  final int totalEmployees;
  final int checkInEmployees;
  final int checkOutEmployees;
  final bool? isCheckIn;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyCard(
      width: size.width,
      clip: Clip.antiAliasWithSaveLayer,
      borderRadius: BorderRadius.circular(
        SizeUtils.scale(14, size.width),
      ),
      border: Border.all(
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
      boxShadow: const [],
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.scale(10, size.width),
        vertical: SizeUtils.scale(12, size.width),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
              text: title ?? "Title",
              style: AppFonts.TitleSmall.copyWith(
                  color: Theme.of(context).colorScheme.onBackground)),
          Row(
            children: [
              percent != null && percent != 0
                  ? Expanded(
                      flex: percent != null && percent != 0
                          ? (percent! * 100).toInt()
                          : 1,
                      child: LinearPercentIndicator(
                        animation: true,
                        lineHeight:
                            indicatorHeight ?? SizeUtils.scale(5, size.width),
                        animationDuration: 250,
                        padding: EdgeInsets.zero,
                        percent: 1,
                        barRadius: Radius.circular(
                          SizeUtils.scale(
                              AppSize().borderRadiusLarge, size.width),
                        ),
                        progressColor:
                            color ?? Theme.of(context).colorScheme.primary,
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                  width: SizeUtils.scale(
                      percent != null && percent == 0 ? 0 : 6, size.width)),
              percent != null && percent! < 1
                  ? Expanded(
                      flex: (percent != null && percent != 0
                              ? (1 - percent!) * 100
                              : 100)
                          .toInt(),
                      child: LinearPercentIndicator(
                        animation: true,
                        lineHeight:
                            indicatorHeight ?? SizeUtils.scale(5, size.width),
                        animationDuration: 250,
                        padding: EdgeInsets.zero,
                        percent: percent != null && percent != 0
                            ? percent! / 15
                            : 1 / 55,
                        barRadius: Radius.circular(
                          SizeUtils.scale(
                              AppSize().borderRadiusLarge, size.width),
                        ),
                        progressColor:
                            color ?? Theme.of(context).colorScheme.primary,
                        isRTL: true,
                      ),
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding: EdgeInsets.only(left: SizeUtils.scale(6, size.width)),
                child: MyText(
                  text: percent != null && percent?.isNaN == false
                      ? '${(percent! * 100).toStringAsFixed(0)}%'
                      : "0%",
                  style: AppFonts().bodySmall.copyWith(
                        color: color ?? Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ],
          ),
          MyText(
            text: '@employee out of @total employees are @title.'.trParams({
              'employee': isCheckIn == true
                  ? '$checkInEmployees'
                  : '$checkOutEmployees',
              'total': '$totalEmployees',
              'title': title?.toLowerCase() ?? "present",
            }),
            style: AppFonts.BodyXXSmall,
          ),
        ],
      ),
    );
  }
}
