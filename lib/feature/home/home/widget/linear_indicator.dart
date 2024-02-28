import 'package:get/get.dart';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/card/my_card.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LinearIndicator extends StatelessWidget {
  const LinearIndicator({
    super.key,
    this.percent,
    this.indicatorHeight,
    this.indicatorColor,
    this.title,
    this.checkInEmployees = 0,
    this.checkOutEmployees = 0,
    this.totalEmployees = 0,
    this.isCheckIn = true,
  });

  final String? title;
  final double? percent;
  final double? indicatorHeight;
  final Color? indicatorColor;
  final int totalEmployees;
  final int checkInEmployees;
  final int checkOutEmployees;
  final bool? isCheckIn;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyCard(
      width: size.width,
      height: SizeUtils.scale(85, size.width),
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.scale(20, size.width),
        vertical: SizeUtils.scale(10, size.width),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyText(text: title ?? "Title", style: AppStyles().bodyMedium),
          Row(
            children: [
              Expanded(
                child: LinearPercentIndicator(
                  animation: true,
                  lineHeight:
                      indicatorHeight ?? SizeUtils.scale(15, size.width),
                  animationDuration: 250,
                  padding: EdgeInsets.zero,
                  percent: percent ?? 0,
                  barRadius: Radius.circular(
                    SizeUtils.scale(AppSize().borderRadiusLarge, size.width),
                  ),
                  progressColor:
                      indicatorColor ?? Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(width: SizeUtils.scale(10, size.width)),
              MyText(
                text: percent != null && percent?.isNaN == false
                    ? '${(percent! * 100).toStringAsFixed(2)}%'
                    : "0.00%",
                style: AppStyles().bodySmall.copyWith(
                      color: indicatorColor ??
                          Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
          Align(
            child: MyText(
              text: '@employee out of @total employees are present'.trParams({
                'employee': isCheckIn == true
                    ? '$checkInEmployees'
                    : '$checkOutEmployees',
                'total': '$totalEmployees',
              }),
              style: AppStyles().bodySmallRegular,
            ),
          ),
        ],
      ),
    );
  }
}
