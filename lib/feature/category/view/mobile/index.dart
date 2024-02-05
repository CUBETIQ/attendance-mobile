import 'package:flutter/material.dart';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/card/my_card.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/category/controller/index.dart';
import 'package:timesync360/utils/size_util.dart';

class CategoryViewMobile extends StatelessWidget {
  const CategoryViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Category",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeUtils.scale(
                AppSize.paddingHorizontalLarge,
                size.width,
              ),
              horizontal: AppSize.paddingVerticalLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "Category Overview",
                  style: BodyXlargeMedium,
                ),
                SizedBox(
                  height: SizeUtils.scale(30, size.width),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.categories.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: SizeUtils.scale(10, size.width),
                    );
                  },
                  itemBuilder: (context, index) {
                    return MyCard(
                      height: SizeUtils.scale(60, size.width),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
