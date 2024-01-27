import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/feature/customer_support/model/support_button.dart';
import 'package:flutter/material.dart';

class SupportButton extends StatelessWidget {
  const SupportButton({
    super.key,
    this.onTap,
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    required this.buttonModel,
  });

  final void Function()? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? backgroundColor;
  final SupportButtonModel buttonModel;

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
        child: Row(
          children: [
            Row(),
            Icon(
              Icons.arrow_back_ios,
            )
          ],
        ),
      ),
    );
  }
}
