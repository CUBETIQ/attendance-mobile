import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    this.width,
    this.height,
    this.child,
    this.backgroundColor,
    this.padding,
  });

  final double? width;
  final double? height;
  final Widget? child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: width ?? size.width,
      height: height ?? SizeUtils.scale(150, size.width),
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(AppSize.paddingS1, size.width),
            vertical:
                SizeUtils.scale(AppSize.paddingVerticalMedium, size.width),
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeUtils.scale(AppSize.borderRadiusLarge, size.width),
        ),
        color: backgroundColor ?? Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}
