import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:flutter/material.dart';

class MyAsyncButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final Future<void> Function() onTap;
  final TextStyle? style;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool? isIconButton;
  final EdgeInsetsGeometry? margin;
  final IconData? icon;
  final double? iconSize;

  const MyAsyncButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.onTap,
    this.style,
    this.backgroundColor,
    this.borderRadius,
    this.isIconButton = false,
    this.margin,
    this.icon,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RxBool isDisableButton = false.obs;
    return Obx(
      () => GestureDetector(
        onTap: isDisableButton.value == false
            ? () async {
                try {
                  isDisableButton.value = true;
                  await onTap();
                } catch (e) {
                  Logger().e(e);
                  return;
                } finally {
                  isDisableButton.value = false;
                }
              }
            : null,
        child: Container(
          width: width ?? double.infinity,
          height: height ?? 48 * (size.width / 375.0),
          margin: margin,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              (borderRadius ?? AppSize().borderRadiusLarge) *
                  (size.width / 375.0),
            ),
            color: isDisableButton.value == true
                ? Theme.of(context).colorScheme.outline
                : backgroundColor ?? Theme.of(context).colorScheme.primary,
          ),
          child: isIconButton == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon ?? Icons.check_circle_outline_rounded,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: iconSize,
                    ),
                    SizedBox(width: size.width * 0.01),
                    MyText(
                      text: title,
                      style: style ??
                          AppStyles().bodyLargeMedium.copyWith(
                                color: isDisableButton.value == true
                                    ? Theme.of(context).colorScheme.outline
                                    : Theme.of(context).colorScheme.onPrimary,
                              ),
                    ),
                  ],
                )
              : MyText(
                  text: title,
                  style: style ??
                      AppStyles().bodyLargeMedium.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                ),
        ),
      ),
    );
  }
}