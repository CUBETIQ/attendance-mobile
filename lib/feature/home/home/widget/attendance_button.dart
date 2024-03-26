import 'package:flutter/material.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';

class AttendanceButton extends StatelessWidget {
  const AttendanceButton(
      {super.key,
      this.label,
      this.svgIcon,
      this.color,
      this.onTap,
      this.onlyBorder});

  final String? label;
  final String? svgIcon;
  final Color? color;
  final bool? onlyBorder;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: onlyBorder == true ? null : color,
          border:
              Border.all(color: color ?? Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(
            SizeUtils.scale(AppSpacing.L, size.width),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeUtils.scale(22, size.width),
              horizontal: SizeUtils.scale(24, size.width)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: SizeUtils.scale(7, size.width)),
                child: SvgIcon(
                  icon: svgIcon ?? '',
                  color: onlyBorder == true
                      ? color
                      : Theme.of(context).colorScheme.onPrimary,
                  height: SizeUtils.scale(21, size.width),
                  width: SizeUtils.scale(21, size.width),
                ),
              ),
              MyText(
                text: label ?? '',
                style: AppFonts.TitleSmall.copyWith(
                    color: onlyBorder == true
                        ? color
                        : Theme.of(context).colorScheme.onPrimary),
              )
            ],
          ),
        ),
      ),
    );
  }
}
