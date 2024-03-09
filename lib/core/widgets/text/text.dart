import 'package:timesync/constants/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextStyle? style;

  const MyText({
    super.key,
    required this.text,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.textDirection,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      maxLines: maxLines ?? 1,
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      style: style ?? AppFonts().bodySmallMedium,
    );
  }
}
