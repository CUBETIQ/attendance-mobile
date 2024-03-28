import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class DetailRowData extends StatelessWidget {
  const DetailRowData({super.key, this.title, this.value, this.valueColor});

  final String? title;
  final String? value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: SizeUtils.scale(150, size.width),
          child: MyText(
            text: title ?? "status",
            style: AppFonts.LabelMedium.copyWith(
                color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        MyText(
          text: value ?? "Value",
          style: AppFonts.TitleSmall.copyWith(
              color: valueColor ?? Theme.of(context).colorScheme.onBackground),
        ),
      ],
    );
  }
}
