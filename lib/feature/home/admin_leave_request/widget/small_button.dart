import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_size.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    this.onTap,
    required this.size,
    required this.title,
    this.backgroundColor,
  });

  final void Function()? onTap;
  final Size size;
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeUtils.scale(30, size.width),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize().borderRadiusMedium * (size.width / 375.0),
          ),
          color: backgroundColor ?? Theme.of(context).colorScheme.primary,
        ),
        child: MyText(
          text: title,
          style: AppFonts().bodySmallMedium.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
    );
  }
}
