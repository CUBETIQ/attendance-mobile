import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/utils/size_util.dart';

class MyLinearProgressIndicator extends StatelessWidget {
  const MyLinearProgressIndicator({
    super.key,
    this.indicatorHeight,
    this.percent,
    this.color,
    this.trailing,
  });

  final double? indicatorHeight;
  final double? percent;
  final Color? color;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        percent != null && percent != 0
            ? Expanded(
                flex: percent != null && percent != 0
                    ? (percent! * 100).toInt()
                    : 1,
                child: LinearPercentIndicator(
                  animation: true,
                  lineHeight: indicatorHeight ?? SizeUtils.scale(5, size.width),
                  animationDuration: 250,
                  padding: EdgeInsets.zero,
                  percent: 1,
                  barRadius: Radius.circular(
                    SizeUtils.scale(AppSize().borderRadiusLarge, size.width),
                  ),
                  progressColor: color ?? Theme.of(context).colorScheme.primary,
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
                  lineHeight: indicatorHeight ?? SizeUtils.scale(5, size.width),
                  animationDuration: 250,
                  padding: EdgeInsets.zero,
                  percent:
                      percent != null && percent != 0 ? percent! / 15 : 1 / 55,
                  barRadius: Radius.circular(
                    SizeUtils.scale(AppSize().borderRadiusLarge, size.width),
                  ),
                  progressColor: color ?? Theme.of(context).colorScheme.primary,
                  isRTL: true,
                ),
              )
            : const SizedBox.shrink(),
        trailing ?? const SizedBox.shrink(),
      ],
    );
  }
}
