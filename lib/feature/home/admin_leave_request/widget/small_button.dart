import 'package:timesync360/config/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';

import '../../../../config/app_size.dart';

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
            AppSize.borderRadiusMedium * (size.width / 375.0),
          ),
          color: backgroundColor ?? Theme.of(context).colorScheme.primary,
        ),
        child: MyText(
          text: title,
          style: BodySmallMedium.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
