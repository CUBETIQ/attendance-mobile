import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/lotties.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';

class PointCard extends StatelessWidget {
  const PointCard({super.key, this.width, this.height, this.point});

  final double? width;
  final double? height;
  final int? point;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyCard(
      width: size.width,
      height: SizeUtils.scaleMobile(155, size.width),
      backgroundColor: Theme.of(context).colorScheme.primary,
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.scaleMobile(
          AppSize().paddingHorizontalLarge,
          size.width,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LottieBuilder.asset(
                LottieAssets.coin,
                width: SizeUtils.scaleMobile(50, size.width),
                height: SizeUtils.scaleMobile(50, size.width),
              ),
              SizedBox(width: SizeUtils.scaleMobile(15, size.width)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "${point ?? 0} pts",
                    style: AppFonts().bodyXlarge.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  MyText(
                    text: "Total points earned",
                    style: AppFonts().bodyLargeRegular.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              )
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
          ),
          MyText(
            text:
                "You can more points by check in daily and completing the task",
            maxLines: 4,
            style: AppFonts().bodySmallMedium.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          SizedBox(height: SizeUtils.scaleMobile(5, size.width)),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: SizeUtils.scaleMobile(
                AppSize().paddingS1,
                size.width,
              ),
              horizontal: SizeUtils.scaleMobile(
                AppSize().paddingS5,
                size.width,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                SizeUtils.scaleMobile(
                  AppSize().borderRadiusMedium,
                  size.width,
                ),
              ),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: MyText(
              text: "Redeem Now",
              style: AppFonts().bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
