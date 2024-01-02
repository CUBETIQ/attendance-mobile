import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskChart extends StatelessWidget {
  final Size size;
  final double radius;
  final double? lineWidth;
  final double? percent;
  final Widget? centerWidget;
  final double? height;
  final String? title;
  final String? textBelow;
  final double? width;

  const TaskChart({
    super.key,
    required this.size,
    required this.radius,
    this.lineWidth,
    this.percent,
    this.centerWidget,
    this.height,
    this.title,
    this.textBelow,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: width,
      height: height ?? 210 * (size.width / 360),
      padding: EdgeInsets.symmetric(
        vertical: SizeUtils.scale(AppSize.paddingS8, size.width),
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
            spreadRadius: 1.2,
            blurRadius: 1.2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(text: title ?? "MyTask", style: BodyLargeMedium),
          SizedBox(height: SizeUtils.scale(10, size.width)),
          CircularPercentIndicator(
            animation: true,
            animationDuration: 500,
            radius: radius * (size.width / 360),
            lineWidth: lineWidth ?? 20.0,
            percent: percent ?? 0,
            center: centerWidget,
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
          MyText(text: textBelow ?? "MyTask", style: BodyMediumRegular),
        ],
      ),
    );
  }
}
