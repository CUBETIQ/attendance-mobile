import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
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
          style: AppFonts().bodyMediumRegular,
        ),
        MyText(
          text: value ?? "Value",
          style: style ??
              AppFonts().bodyMediumMedium.copyWith(
                    color:
                        textColor ?? Theme.of(context).colorScheme.onBackground,
                  ),
        )
      ],
    );
  }
}
