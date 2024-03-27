import 'package:get/get.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/progress_indicator/linear_progress_indicator.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

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
    this.onTap,
  });

  final String? title;
  final double? percent;
  final double? indicatorHeight;
  final Color? color;
  final int totalEmployees;
  final int checkInEmployees;
  final int checkOutEmployees;
  final bool? isCheckIn;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: MyCard(
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
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            MyLinearProgressIndicator(
              percent: percent,
              color: color,
              indicatorHeight: indicatorHeight,
              trailing: Padding(
                padding: EdgeInsets.only(left: SizeUtils.scale(6, size.width)),
                child: MyText(
                  text: percent != null && percent?.isNaN == false
                      ? percent! >= 0 && percent! <= 1
                          ? '${(percent! * 100).toStringAsFixed(0)}%'
                          : "100%"
                      : "0%",
                  style: AppFonts().bodySmall.copyWith(
                        color: color ?? Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
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
      ),
    );
  }
}
