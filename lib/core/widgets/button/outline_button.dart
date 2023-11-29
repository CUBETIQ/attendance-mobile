import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:flutter/material.dart';

class MyOutLineButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final void Function()? onTap;

  const MyOutLineButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1.5,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: MyText(
          text: title,
          style: BodyLargeMedium,
        ),
      ),
    );
  }
}
