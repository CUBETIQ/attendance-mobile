import 'package:timesync360/config/app_size.dart';
import 'package:timesync360/core/widgets/button/button.dart';
import 'package:timesync360/feature/onboard/controller/index.dart';
import 'package:timesync360/feature/onboard/widgets/page.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardViewMobile extends StatelessWidget {
  const OnBoardViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.83,
                child: PageView(
                  onPageChanged: controller.onChange,
                  controller: controller.pageController,
                  children: controller.onBoardList
                      .map(
                        (e) => MyPage(
                          image: e.image,
                          width: size.width,
                          height: size.height * 0.55,
                          title: e.title,
                          description: e.description,
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.scale(
                    AppSize.paddingHorizontalLarge,
                    MediaQuery.of(context).size.width,
                  ),
                ),
                child: Obx(
                  () => MyButton(
                    title: controller.currentIndex.value != 2
                        ? "Next"
                        : "Get Started",
                    onTap: controller.onTapButton,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
