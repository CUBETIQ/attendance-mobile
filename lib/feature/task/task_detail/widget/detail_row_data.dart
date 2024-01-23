import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';

class DetailRowData extends StatelessWidget {
  const DetailRowData({super.key, this.title, this.value});

  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: SizeUtils.scale(160, size.width),
          child: MyText(
            text: title ?? "status",
            style: BodyMediumMedium.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
        MyText(
          text: value ?? "Value",
          style: BodyMediumMedium,
        ),
      ],
    );
  }
}
