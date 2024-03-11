import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/profile/earn_point/controller/index.dart';
import 'package:timesync/feature/profile/earn_point/widget/earn_point_card.dart';
import 'package:timesync/feature/profile/earn_point/widget/point_card.dart';
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
        onRefresh: controller.getEarnPoint,
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeUtils.scale(
                    AppSize().paddingHorizontalLarge, size.width),
                right: SizeUtils.scale(
                    AppSize().paddingHorizontalLarge, size.width),
                top: SizeUtils.scale(AppSize().paddingS17, size.width),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => PointCard(
                      point: controller.point.value.points,
                    ),
                  ),
                  SizedBox(height: SizeUtils.scale(20, size.width)),
                  MyText(
                    text: "Earn More Points",
                    style: AppFonts().bodyXlargeMedium.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  SizedBox(height: SizeUtils.scale(10, size.width)),
                  EarnPointCard(
                    onTap: controller.onTapCheckIn,
                    title: "Check In Daily",
                    point: 2,
                  ),
                  SizedBox(height: SizeUtils.scale(10, size.width)),
                  EarnPointCard(
                    onTap: controller.onTapTask,
                    title: "Complete Task",
                    point: 1,
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
