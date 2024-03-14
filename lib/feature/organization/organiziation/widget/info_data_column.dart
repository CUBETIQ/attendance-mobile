import 'package:flutter/material.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';

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
    return Padding(
      padding: EdgeInsets.only(bottom: SizeUtils.scale(10, size.width)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          SizedBox(
            width: SizeUtils.scale(5, size.width),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                MyText(
                  text: title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: AppFonts().bodyMediumMedium,
                ),
                SizedBox(
                  height: SizeUtils.scale(3, size.width),
                ),
                MyText(
                  text: value,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
