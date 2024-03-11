import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';

class EarnPointCard extends StatelessWidget {
  const EarnPointCard({super.key, this.title, this.point, this.onTap});

  final String? title;
  final int? point;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: MyCard(
        width: size.width,
        boxShadow: const [],
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.scale(
            AppSize().paddingHorizontalMedium,
            size.width,
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        height: SizeUtils.scale(80, size.width),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  SvgAssets.coin,
                  width: SizeUtils.scale(35, size.width),
                  height: SizeUtils.scale(35, size.width),
                ),
                SizedBox(
                  width: SizeUtils.scale(10, size.width),
                ),
                MyText(
                  text: title ?? "Title",
                  style: AppFonts().bodyLargeMedium.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ],
            ),
            MyText(
              text: "+${point ?? 0}pts",
              style: AppFonts().bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
