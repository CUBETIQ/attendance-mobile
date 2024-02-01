import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';

class SmallOutlineButton extends StatelessWidget {
  const SmallOutlineButton({
    super.key,
    this.onTap,
    required this.size,
    required this.title,
    this.borderColor,
  });

  final void Function()? onTap;
  final Size size;
  final String title;
  final Color? borderColor;

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
          border: Border.all(
            color: Theme.of(context).colorScheme.error,
            width: 1.5,
          ),
        ),
        child: MyText(
          text: title,
          style: BodySmallMedium,
        ),
      ),
    );
  }
}
