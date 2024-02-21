import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/feature/category/category/controller/index.dart';
import 'package:timesync360/feature/category/category/widget/category_card.dart';
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
      body: MyRefreshIndicator(
        onRefresh: controller.onRefresh,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: SizeUtils.scale(10, size.width),
                horizontal: SizeUtils.scale(24, size.width),
              ),
              child: Obx(
                () => Wrap(
                  spacing: SizeUtils.scale(8, size.width),
                  alignment: WrapAlignment.start,
                  children: [
                    ...List.generate(
                      controller.categories.length,
                      (index) => CategoryCard(
                        onTap: () => controller.onTapCategory(
                          controller.categories[index],
                        ),
                        category: controller.categories[index],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onTapAddCategory,
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