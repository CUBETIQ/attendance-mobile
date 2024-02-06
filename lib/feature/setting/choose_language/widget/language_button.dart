import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/card/my_card.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
    this.width,
    this.height,
    this.isSelected = false,
    required this.title,
    required this.imageFlag,
    this.onTap,
  });

  final String imageFlag;
  final String title;
  final double? width;
  final double? height;
  final bool? isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: MyCard(
        width: width ?? size.width,
        height: height ?? SizeUtils.scale(55, size.width),
        padding: EdgeInsets.symmetric(
          horizontal:
              SizeUtils.scale(AppSize().paddingHorizontalLarge, size.width),
        ),
        margin: EdgeInsets.only(
          bottom: SizeUtils.scale(10, size.width),
        ),
        backgroundColor: isSelected == false
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).colorScheme.secondaryContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  imageFlag,
                  width: SizeUtils.scale(40, size.width),
                ),
                SizedBox(width: SizeUtils.scale(15, size.width)),
                MyText(
                  text: title,
                  style: BodyLargeMedium,
                ),
              ],
            ),
            isSelected == true
                ? Icon(
                    Icons.check_circle_outline_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: SizeUtils.scale(24, size.width),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
