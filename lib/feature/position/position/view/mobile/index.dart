import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync360/core/widgets/no_data/no_data.dart';
import 'package:timesync360/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/position/position/controller/index.dart';
import 'package:timesync360/feature/position/position/widget/position_card.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/button/back_button.dart';

class PositionViewMobile extends StatelessWidget {
  const PositionViewMobile({super.key});

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
        elevation: 2,
      ),
      body: MyRefreshIndicator(
        onRefresh: controller.onRefresh,
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                children: [
                  MyText(text: "Position Overview", style: BodyLargeMedium),
                  SizedBox(height: AppSize().paddingS8),
                  SearchBar(
                    hintText: "Search Position",
                    elevation: MaterialStateProperty.all<double>(0.2),
                    onSubmitted: controller.searchPosition,
                    leading: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {},
                      icon: const Icon(Icons.search_rounded),
                    ),
                    trailing: [
                      IconButton(
                        onPressed: controller.clearSearch,
                        icon: const Icon(Icons.cancel_rounded),
                      ),
                    ],
                    controller: controller.searchController,
                  ),
                  SizedBox(height: AppSize().paddingS8),
                  Obx(
                    () => MyAsyncWidget(
                      isLoading: controller.isLoading.value,
                      list: controller.positionList.value,
                      noDataWidget: const MyNoData(),
                      builderWidget: ListView.separated(
                        itemCount: controller.positionList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                ],
              ),
            ),
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
        elevation: 2,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
