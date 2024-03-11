import 'package:flutter/material.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/utils/color_utils.dart';
import 'package:timesync/utils/size_util.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    super.key,
    this.width,
    this.height,
    required this.icon,
    this.bgColor,
    this.iconSize,
  });

  final double? width;
  final double? height;
  final String? icon;
  final String? bgColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: width ?? SizeUtils.scale(75, size.width),
      height: width ?? SizeUtils.scale(75, size.width),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor != null && bgColor?.isNotEmpty == true
            ? Color(bgColor!.toInt()).withOpacity(0.15)
            : Theme.of(context).colorScheme.primary.withOpacity(0.15),
      ),
      child: Icon(
        icon != null && icon?.isNotEmpty == true
            ? IconData(
                icon!.toInt(),
                fontFamily: 'MaterialIcons',
              )
            : Icons.task,
        color: bgColor != null && bgColor?.isNotEmpty == true
            // Darken the color by 20%
            ? ColorUtil.darken(Color(bgColor!.toInt()), 20)
            : ColorUtil.darken(Theme.of(context).colorScheme.primary, 20),
        size: iconSize ?? SizeUtils.scale(50, size.width),
      ),
    );
  }
}
