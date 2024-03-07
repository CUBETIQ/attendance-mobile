import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:flutter/material.dart';

class RoundedColorPicker extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  final bool? haslabel;
  final String? label;

  const RoundedColorPicker({
    super.key,
    this.onTap,
    this.color,
    this.haslabel = true,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: haslabel == true ? AppSize().paddingS5 : 0),
            child: Container(
              width: 55 * (size.width / 375.0),
              height: 55 * (size.width / 375.0),
              decoration: BoxDecoration(
                color: color ?? Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          haslabel == true
              ? MyText(
                  text: label ?? "Color",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: AppFonts().bodyMediumMedium,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
