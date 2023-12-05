import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/feature/onboard/controller/index.dart';
import 'package:attendance_app/feature/onboard/widgets/page.dart';
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
                height: size.height * 0.84,
                child: PageView(
                  onPageChanged: controller.onChange,
                  controller: controller.pageController,
                  children: controller.onBoardList
                      .map(
                        (e) => MyPage(
                          image: e.image,
                          width: size.width,
                          height: size.height * 0.60,
                          title: e.title,
                          description: e.description,
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.paddingHorizontalLarge,
                  vertical: AppSize.paddingVerticalSmall,
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
