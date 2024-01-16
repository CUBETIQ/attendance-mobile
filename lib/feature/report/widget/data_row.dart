import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:flutter/material.dart';

class DataRowReport extends StatelessWidget {
  const DataRowReport({
    super.key,
    this.title,
    this.value,
    this.style,
    this.textColor,
  });

  final String? title;
  final String? value;
  final TextStyle? style;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          text: title ?? "Title",
          style: BodyMediumRegular,
        ),
        MyText(
          text: value ?? "Value",
          style: style ??
              BodyMediumMedium.copyWith(
                color: textColor ?? Theme.of(context).colorScheme.onBackground,
              ),
        )
      ],
    );
  }
}
