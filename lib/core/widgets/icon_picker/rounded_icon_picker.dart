import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/extensions/string.dart';
import 'package:flutter/material.dart';
import '../text/text.dart';

class RoundedIconPicker extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  final String? icon;

  const RoundedIconPicker({super.key, this.onTap, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        MyText(
          text: "Icon",
          style: BodyMediumMedium,
        ),
        const SizedBox(height: AppSize.paddingS5),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 55 * (size.width / 375.0),
            height: 55 * (size.width / 375.0),
            decoration: BoxDecoration(
              color: color ?? Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon?.isEmpty == false || icon != null
                  ? IconData(icon!.toInt(), fontFamily: 'MaterialIcons')
                  : Icons.task,
              color: Colors.white,
              size: 26 * (size.width / 375.0),
            ),
          ),
        ),
      ],
    );
  }
}
