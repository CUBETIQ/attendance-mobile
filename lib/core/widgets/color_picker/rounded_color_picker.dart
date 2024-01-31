import 'package:timesync360/config/app_size.dart';
import 'package:timesync360/config/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:flutter/material.dart';

class RoundedColorPicker extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;

  const RoundedColorPicker({super.key, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        MyText(
          text: "Color",
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
          ),
        ),
      ],
    );
  }
}
