import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';

class AttendanceInfoWidget extends StatelessWidget {
  final String title;
  final int? value;
  final Color? color;

  const AttendanceInfoWidget({
    super.key,
    required this.title,
    this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          width: SizeUtils.scale(12, size.width),
          height: SizeUtils.scale(12, size.width),
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(
              SizeUtils.scale(10, size.width),
            ),
          ),
        ),
        SizedBox(width: SizeUtils.scale(10, size.width)),
        MyText(
          text: title,
          style: AppStyles().bodyMediumRegular,
        ),
        MyText(
          text: "${value ?? 0}",
          style: AppStyles().bodyMediumRegular,
        ),
      ],
    );
  }
}
