import 'package:timesync/constants/app_size.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    this.width,
    this.height,
    this.child,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.boxShadow,
    this.clip,
    this.alignment,
    this.border,
    this.gradient,
  });

  final double? width;
  final double? height;
  final Widget? child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Clip? clip;
  final AlignmentGeometry? alignment;
  final BoxBorder? border;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: margin,
      width: width ?? size.width,
      height: height,
      alignment: alignment,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(AppSize().paddingS1, size.width),
            vertical:
                SizeUtils.scale(AppSize().paddingVerticalMedium, size.width),
          ),
      clipBehavior: clip ?? Clip.none,
      decoration: BoxDecoration(
        borderRadius: borderRadius ??
            BorderRadius.circular(
              SizeUtils.scale(
                AppSize().borderRadiusLarge,
                size.width,
              ),
            ),
        gradient: gradient,
        border: border,
        color: backgroundColor ?? Theme.of(context).colorScheme.background,
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1.5,
                blurRadius: 1.5,
                offset: const Offset(0, 0),
              ),
            ],
      ),
      child: child,
    );
  }
}
