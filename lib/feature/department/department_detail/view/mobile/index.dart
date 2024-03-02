import 'package:flutter/material.dart';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/card/label_description_card.dart';
import 'package:timesync360/core/widgets/card/label_detail_card.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/feature/department/department_detail/controller/index.dart';
import 'package:timesync360/utils/size_util.dart';

class DepartmentDetailViewMobile extends StatelessWidget {
  const DepartmentDetailViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DepartmentDetailController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Department Detail",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scaleMobile(
              AppSize().paddingHorizontalLarge,
              size.width,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: SizeUtils.scaleMobile(30, size.width)),
              Center(
                child: MyCacheImage(
                  imageUrl: controller.department.value?.image,
                  width: SizeUtils.scaleMobile(100, size.width),
                  height: SizeUtils.scaleMobile(100, size.width),
                  defaultImage: SvgAssets.position,
                  imageHeight: SizeUtils.scaleMobile(75, size.width),
                  imageWidth: SizeUtils.scaleMobile(75, size.width),
                ),
              ),
              SizedBox(height: SizeUtils.scaleMobile(30, size.width)),
              LabelDetailCard(
                title: "Name",
                value: controller.department.value?.name,
              ),
              LabelDescriptionCard(
                title: "Description",
                value: controller.department.value?.description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
