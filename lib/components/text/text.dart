import 'package:cubetiq_attendance_app/config/extension/translate.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText(
      {super.key,
      required this.text,
      this.style,
      this.textAlign,
      this.softWrap,
      this.overflow,
      this.maxLines});

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.trString,
      style: style ?? Theme.of(context).textTheme.bodySmall,
      textAlign: textAlign ?? TextAlign.center,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines ?? 1,
    );
  }
}
