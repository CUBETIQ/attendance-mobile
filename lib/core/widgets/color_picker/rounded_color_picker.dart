import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:flutter/material.dart';

class RoundedColorPicker extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  final bool? haslabel;

  const RoundedColorPicker({
    super.key,
    this.onTap,
    this.color,
    this.haslabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        haslabel == true
            ? MyText(
                text: "Color",
                style: AppStyles().bodyMediumMedium,
              )
            : const SizedBox.shrink(),
        SizedBox(height: AppSize().paddingS5),
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
