import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class InfoDataColumn extends StatelessWidget {
  const InfoDataColumn({
    super.key,
    this.icon,
    this.iconColor,
    required this.title,
    required this.value,
  });

  final IconData? icon;
  final Color? iconColor;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(
              width: SizeUtils.scale(5, size.width),
            ),
            MyText(
              text: title,
              style: AppFonts().bodyMediumMedium,
            ),
          ],
        ),
        SizedBox(
          height: SizeUtils.scale(3, size.width),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: SizeUtils.scale(20, size.width),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: SizeUtils.scale(270, size.width),
            ),
            child: MyText(
              text: value,
              maxLines: 10,
            ),
          ),
        ),
      ],
    );
  }
}
