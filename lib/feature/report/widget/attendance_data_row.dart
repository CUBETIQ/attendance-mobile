import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:flutter/material.dart';

class AttendanceDataRowReport extends StatelessWidget {
  const AttendanceDataRowReport({
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
          style: AppStyles().bodyMediumRegular,
        ),
        MyText(
          text: value ?? "Value",
          style: style ??
              AppStyles().bodyMediumMedium.copyWith(
                    color:
                        textColor ?? Theme.of(context).colorScheme.onBackground,
                  ),
        )
      ],
    );
  }
}
