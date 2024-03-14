import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/no_data/no_data.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/position/position/controller/index.dart';
import 'package:timesync/feature/position/position/widget/position_card.dart';
import 'package:timesync/utils/size_util.dart';

class PositionView extends StatelessWidget {
  const PositionView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = PositionController.to;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Position",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: MyRefreshIndicator(
        onRefresh: controller.onRefresh,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeUtils.scale(
              AppSize().paddingHorizontalLarge,
              size.width,
            ),
            horizontal: AppSize().paddingVerticalLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                  text: "Position Overview", style: AppFonts().bodyLargeMedium),
              SizedBox(height: AppSize().paddingS8),
              SizedBox(
                height: SizeUtils.scale(50, size.width),
                child: SearchBar(
                  hintText: "Search Position",
                  elevation: MaterialStateProperty.all<double>(0.2),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    AppFonts().bodyMediumMedium.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  constraints: BoxConstraints.loose(size),
                  onSubmitted: controller.searchPosition,
                  leading: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {},
                    icon: const Icon(Icons.search_rounded),
                    iconSize: SizeUtils.scale(20, size.width),
                  ),
                  trailing: [
                    IconButton(
                      onPressed: controller.clearSearch,
                      icon: const Icon(Icons.cancel_rounded),
                      iconSize: SizeUtils.scale(20, size.width),
                    ),
                  ],
                  controller: controller.searchController,
                ),
              ),
              SizedBox(height: AppSize().paddingS8),
              Expanded(
                child: Obx(
                  () => MyAsyncWidget(
                    isLoading: controller.isLoading.value,
                    list: controller.positionList.value,
                    noDataWidget: const MyNoData(),
                    builderWidget: ListView.separated(
                      itemCount: controller.positionList.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                        height: SizeUtils.scale(
                          AppSize().paddingS8,
                          size.width,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        return PositionCard(
                          onTap: () => controller.onTapPosition(
                            controller.positionList[index],
                          ),
                          onTapViewDetail: () => controller.onTapViewDetail(
                            controller.positionList[index],
                          ),
                          position: controller.positionList[index],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onTapAddPosition,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
