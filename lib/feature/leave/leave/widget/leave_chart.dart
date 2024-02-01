import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class LeaveChart extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final double? lineWidth;
  final double? percent;
  final String? textBelow;
  final String title;
  final String? centerText;

  const LeaveChart({
    super.key,
    this.width,
    this.height,
    required this.radius,
    this.lineWidth,
    this.percent,
    required this.title,
    this.textBelow,
    this.centerText,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: width,
      height: height ?? SizeUtils.scale(160, size.width),
      padding: EdgeInsets.symmetric(
        vertical: SizeUtils.scale(AppSize.paddingS5, size.width),
        horizontal: SizeUtils.scale(AppSize.paddingS8, size.width),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(
          SizeUtils.scale(AppSize.borderRadiusLarge, size.width),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1.1,
            blurRadius: 1.2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          MyText(text: title, style: BodyMediumRegular),
          SizedBox(height: SizeUtils.scale(10, size.width)),
          CircularPercentIndicator(
            animation: true,
            animationDuration: 500,
            radius: radius * (size.width / 360),
            lineWidth: lineWidth ?? 12.0,
            percent: percent?.isNegative == true
                ? 0.0
                : (percent ?? 0) > 1
                    ? 1
                    : percent ?? 0.0,
            center: MyText(
              text: centerText ?? "0%",
              style: BodySmallRegular,
            ),
            linearGradient: const LinearGradient(
              colors: [
                Color(0xFF4049E0),
                Color(0XFF7653C9),
              ],
            ),
            backgroundColor: Colors.grey.withOpacity(0.3),
            circularStrokeCap: CircularStrokeCap.round,
          ),
          SizedBox(height: SizeUtils.scale(10, size.width)),
          MyText(text: textBelow ?? "0/0", style: BodyMediumRegular),
        ],
      ),
    );
  }
}
