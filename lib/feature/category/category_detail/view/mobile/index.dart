import 'package:flutter/material.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/card/label_description_card.dart';
import 'package:timesync/core/widgets/card/label_detail_card.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/category/category_detail/controller/index.dart';
import 'package:timesync/feature/category/category_detail/widget/icon_card.dart';
import 'package:timesync/utils/size_util.dart';

class CategoryDetailViewMobile extends StatelessWidget {
  const CategoryDetailViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryDetailController.to;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Category Detail",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scaleMobile(
              AppSize().paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: SizeUtils.scaleMobile(
                    30, MediaQuery.of(context).size.width),
              ),
              IconCard(
                icon: controller.categories.value.icon,
                bgColor: controller.categories.value.color,
                width: SizeUtils.scaleMobile(
                    100, MediaQuery.of(context).size.width),
                height: SizeUtils.scaleMobile(
                    100, MediaQuery.of(context).size.width),
              ),
              SizedBox(
                height: SizeUtils.scaleMobile(
                    30, MediaQuery.of(context).size.width),
              ),
              LabelDetailCard(
                title: "Name",
                value: controller.categories.value.name,
              ),
              LabelDetailCard(
                title: "Type",
                value: controller.categories.value.type,
              ),
              LabelDescriptionCard(
                title: "Description",
                value: controller.categories.value.description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
