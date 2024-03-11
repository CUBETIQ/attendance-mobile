import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/lotties.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/profile/earn_point/controller/index.dart';
import 'package:timesync/utils/size_util.dart';

class EarnPointViewMobile extends StatelessWidget {
  const EarnPointViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EarnPointController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(title: 'My Reward'),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: MyRefreshIndicator(
        onRefresh: () async {},
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeUtils.scaleMobile(
                    AppSize().paddingHorizontalLarge, size.width),
                right: SizeUtils.scaleMobile(
                    AppSize().paddingHorizontalLarge, size.width),
                top: SizeUtils.scaleMobile(AppSize().paddingS17, size.width),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyCard(
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
                            SizedBox(
                                width: SizeUtils.scaleMobile(15, size.width)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "781 pts",
                                  style: AppFonts().bodyXlarge.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                ),
                                MyText(
                                  text: "Total points earned",
                                  style: AppFonts().bodyLargeRegular.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.5),
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
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: MyText(
                            text: "Redeem Now",
                            style: AppFonts().bodyMedium.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: SizeUtils.scaleMobile(20, size.width)),
                  MyText(
                    text: "Earn More Points",
                    style: AppFonts().bodyXlargeMedium.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
                  MyCard(
                    width: size.width,
                    boxShadow: const [],
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.scaleMobile(
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
                    height: SizeUtils.scaleMobile(80, size.width),
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              SvgAssets.coin,
                              width: SizeUtils.scaleMobile(35, size.width),
                              height: SizeUtils.scaleMobile(35, size.width),
                            ),
                            SizedBox(
                              width: SizeUtils.scaleMobile(10, size.width),
                            ),
                            MyText(
                              text: "Earn point by check in",
                              style: AppFonts().bodyLargeMedium.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ],
                        ),
                        MyText(
                          text: "+1pts",
                          style: AppFonts().bodyLarge.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
                  MyCard(
                    width: size.width,
                    boxShadow: const [],
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.scaleMobile(
                          AppSize().paddingHorizontalMedium, size.width),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                    height: SizeUtils.scaleMobile(80, size.width),
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              SvgAssets.coin,
                              width: SizeUtils.scaleMobile(35, size.width),
                              height: SizeUtils.scaleMobile(35, size.width),
                            ),
                            SizedBox(
                              width: SizeUtils.scaleMobile(10, size.width),
                            ),
                            MyText(
                              text: "Earn point by Complete task",
                              style: AppFonts().bodyLargeMedium.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ],
                        ),
                        MyText(
                          text: "+1pts",
                          style: AppFonts().bodyLarge.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
