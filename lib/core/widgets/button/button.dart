import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final void Function()? onTap;
  final TextStyle? style;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool? isIconButton;
  final EdgeInsetsGeometry? margin;
  final IconData? icon;

  const MyButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    this.onTap,
    this.style,
    this.backgroundColor,
    this.borderRadius,
    this.isIconButton = false,
    this.margin,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 48 * (size.width / 375.0),
        margin: margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            (borderRadius ?? AppSize.borderRadiusLarge) * (size.width / 375.0),
          ),
          color: backgroundColor ?? Theme.of(context).colorScheme.primary,
        ),
        child: isIconButton == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon ?? Icons.check_circle_outline_rounded,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  SizedBox(width: size.width * 0.01),
                  MyText(
                    text: title,
                    style: style ??
                        BodyLargeMedium.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              )
            : MyText(
                text: title,
                style: style ??
                    BodyLargeMedium.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
      ),
    );
  }
}
