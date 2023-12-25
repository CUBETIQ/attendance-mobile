import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class LeaveChart extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final double? lineWidth;
  final double? percent;
  final Widget? centerWidget;
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
    this.centerWidget,
    required this.title,
    this.textBelow,
    this.centerText,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: width,
      height: height ?? 155 * (MediaQuery.of(context).size.width / 360),
      padding: EdgeInsets.symmetric(
        vertical: SizeUtils.scaleWidth(AppSize.paddingS8, size.width),
        horizontal: SizeUtils.scaleWidth(AppSize.paddingS8, size.width),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(
          SizeUtils.scaleWidth(AppSize.borderRadiusLarge, size.width),
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
          SizedBox(height: SizeUtils.scaleWidth(10, size.width)),
          CircularPercentIndicator(
            animation: true,
            animationDuration: 500,
            radius: radius * (size.width / 360),
            lineWidth: lineWidth ?? 12.0,
            percent: percent ?? 0.8,
            center: MyText(
              text: centerText ?? "80%",
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
          SizedBox(height: SizeUtils.scaleWidth(10, size.width)),
          MyText(text: textBelow ?? "0/0", style: BodyMediumRegular),
        ],
      ),
    );
  }
}
