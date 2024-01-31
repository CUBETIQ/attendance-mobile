import 'package:timesync360/config/font.dart';
import 'package:timesync360/core/widgets/button/button.dart';
import 'package:timesync360/feature/onboard/controller/index.dart';
import 'package:timesync360/feature/onboard/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class OnBoardViewTablet extends StatelessWidget {
  const OnBoardViewTablet({super.key});

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
                          titleStyle: BodyXXXlargeMedium,
                          descriptionStyle: BodyLargeMedium,
                        ),
                      )
                      .toList(),
                ),
              ),
              Obx(
                () => MyButton(
                  title: controller.currentIndex.value != 2
                      ? "Next"
                      : "Get Started",
                  onTap: controller.onTapButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
