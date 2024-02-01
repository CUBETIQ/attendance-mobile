import 'package:flutter/material.dart';
import 'package:timesync360/config/app_size.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/card/label_description_card.dart';
import 'package:timesync360/core/widgets/card/label_detail_card.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/feature/position/position_detail/controller/index.dart';
import 'package:timesync360/utils/size_util.dart';

class PositionDetailViewMobile extends StatelessWidget {
  const PositionDetailViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PositionDetailController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Position Detail",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize.paddingHorizontalLarge,
              size.width,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: SizeUtils.scale(30, size.width)),
              Center(
                child: MyCacheImage(
                  imageUrl: controller.position.value?.image,
                  width: SizeUtils.scale(100, size.width),
                  height: SizeUtils.scale(100, size.width),
                  defaultImage: SvgAssets.position,
                  imageHeight: SizeUtils.scale(75, size.width),
                  imageWidth: SizeUtils.scale(75, size.width),
                ),
              ),
              SizedBox(height: SizeUtils.scale(30, size.width)),
              LabelDetailCard(
                title: "Name",
                value: controller.position.value?.name,
              ),
              LabelDescriptionCard(
                title: "Description",
                value: controller.position.value?.description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
