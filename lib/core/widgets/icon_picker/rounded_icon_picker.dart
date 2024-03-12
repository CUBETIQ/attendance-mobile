import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:timesync/utils/color_utils.dart';
import 'package:timesync/utils/size_util.dart';
import '../text/text.dart';

class RoundedIconPicker extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  final Color? baseColor;
  final String? icon;
  final double? width;
  final double? height;
  final double? iconSize;
  final bool? haslabel;
  final bool? hasOpacity;
  final Color? iconColor;
  final String? label;
  final MainAxisAlignment? mainAxisAlignment;

  const RoundedIconPicker(
      {super.key,
      this.onTap,
      this.color,
      this.icon,
      this.width,
      this.height,
      this.haslabel = true,
      this.iconSize,
      this.hasOpacity = false,
      this.iconColor,
      this.baseColor,
      this.label,
      this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: haslabel == true ? AppSize().paddingS5 : 0),
            child: Container(
              width: width ?? SizeUtils.scale(55, size.width),
              height: height ?? SizeUtils.scale(55, size.width),
              decoration: BoxDecoration(
                border: Border.all(
                  color: baseColor ??
                      color ??
                      Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                color: baseColor ??
                    color?.withOpacity(0.30) ??
                    Theme.of(context).colorScheme.primary.withOpacity(
                          hasOpacity == true ? 0.25 : 1,
                        ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon?.isEmpty == false || icon != null
                    ? IconData(icon!.toInt(), fontFamily: 'MaterialIcons')
                    : Icons.task,
                // darken color by 20%
                color: iconColor ??
                    ColorUtil.darken(
                      color ?? Theme.of(context).colorScheme.primary,
                      20,
                    ),
                size: SizeUtils.scale(iconSize ?? 26, size.width),
              ),
            ),
          ),
          haslabel == true
              ? Flexible(
                  child: MyText(
                    text: label ?? "Icon",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: AppFonts().bodyMediumMedium,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
