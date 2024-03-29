import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_shadow.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';

class MyAsyncButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final Future<void> Function()? onTap;
  final TextStyle? style;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool? isIconButton;
  final EdgeInsetsGeometry? margin;
  final IconData? icon;
  final double? iconSize;
  final bool? hasShadow;

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
    this.hasShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDisableButton = false.obs;
    return Obx(
      () => GestureDetector(
        onTap: isDisableButton.value == false
            ? () async {
                try {
                  isDisableButton.value = true;
                  await onTap!();
                } catch (e) {
                  rethrow;
                } finally {
                  isDisableButton.value = false;
                }
              }
            : null,
        child: Container(
          width: width ?? double.infinity,
          height:
              height ?? SizeUtils.scale(size.width < 600 ? 48 : 50, size.width),
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
              boxShadow: hasShadow == true
                  ? [
                      AppShadow.shadowWithColor(
                          Theme.of(context).colorScheme.primary)
                    ]
                  : []),
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
                          AppFonts.TitleSmall.copyWith(
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
                      AppFonts().bodyLargeMedium.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                ),
        ),
      ),
    );
  }
}
