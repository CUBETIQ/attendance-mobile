import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/extensions/string.dart';
import 'package:flutter/material.dart';
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

  const RoundedIconPicker({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        haslabel == true
            ? MyText(
                text: "Icon",
                style: BodyMediumMedium,
              )
            : const SizedBox.shrink(),
        SizedBox(height: haslabel == true ? 0 : AppSize().paddingS5),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: width ?? 55 * (size.width / 375.0),
            height: height ?? 55 * (size.width / 375.0),
            decoration: BoxDecoration(
              boxShadow: baseColor != null
                  ? []
                  : [
                      BoxShadow(
                        color: color?.withOpacity(0.15) ??
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.15),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
              color: baseColor ??
                  color?.withOpacity(0.25) ??
                  Theme.of(context).colorScheme.primary.withOpacity(
                        hasOpacity == true ? 0.25 : 1,
                      ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon?.isEmpty == false || icon != null
                  ? IconData(icon!.toInt(), fontFamily: 'MaterialIcons')
                  : Icons.task,
              color:
                  iconColor ?? color ?? Theme.of(context).colorScheme.primary,
              size: iconSize ?? 26 * (size.width / 375.0),
            ),
          ),
        ),
      ],
    );
  }
}
