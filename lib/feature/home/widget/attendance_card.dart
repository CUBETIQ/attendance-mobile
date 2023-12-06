import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/color.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AttendanceCard extends StatelessWidget {
  final String image;
  final String title;
  final String? time;
  final String buttonText;
  final Function() onPressed;
  final bool? buttonDisable;
  final double? width;
  final double? height;
  final double? imageWidth;
  final double? imageHeight;
  final double? contentSpacing;
  final double? borderRadius;
  final TextStyle? buttonStyle;
  final TextStyle? titleStyle;
  final TextStyle? timeStyle;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? contentpadding;
  final bool? isCheckedIn;

  const AttendanceCard({
    super.key,
    required this.image,
    required this.title,
    this.time,
    required this.buttonText,
    required this.onPressed,
    this.buttonDisable,
    this.width,
    this.height,
    this.imageWidth,
    this.imageHeight,
    this.contentSpacing,
    this.borderRadius,
    this.buttonStyle,
    this.titleStyle,
    this.timeStyle,
    this.buttonWidth,
    this.buttonHeight,
    this.contentpadding,
    this.isCheckedIn,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.antiAlias,
      width: width ?? size.width * 0.42,
      height: height ?? size.height * 0.30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 25),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            spreadRadius: 1.2,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.all(contentpadding ?? AppSize.paddingVerticalSmall),
            width: imageWidth ?? double.infinity,
            height: imageHeight ?? size.height * 0.12,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
            child: SvgPicture.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: contentSpacing ?? size.height * 0.015),
          MyText(
            text: title,
            style: titleStyle ?? BodyLargeMedium,
          ),
          SizedBox(height: contentSpacing ?? size.height * 0.015),
          MyText(
            text: time ?? "--:--",
            style: timeStyle ?? BodyLargeMedium,
          ),
          SizedBox(height: contentSpacing ?? size.height * 0.015),
          MyButton(
            onTap: isCheckedIn == true
                ? null
                : buttonDisable == true
                    ? null
                    : onPressed,
            title: buttonText,
            style: BodySmallMedium.copyWith(
              color: isCheckedIn == true
                  ? const Color(MyColor.darkSuccess)
                  : buttonDisable == true
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: AppSize.paddingHorizontalMedium,
            ),
            height: size.height * 0.05,
            isIconButton: isCheckedIn,
            borderRadius: 25,
            backgroundColor: isCheckedIn == true
                ? const Color(MyColor.success).withOpacity(0.2)
                : buttonDisable == true
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                    : Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
