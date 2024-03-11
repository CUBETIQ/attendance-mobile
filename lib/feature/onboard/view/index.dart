import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/widgets/button/button.dart';
import 'package:timesync/feature/onboard/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:timesync/feature/onboard/widgets/page.dart';
import 'package:timesync/utils/size_util.dart';

class OnBoardView extends StatelessWidget {
  const OnBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: SizeUtils.scale(
                  600,
                  size.width,
                ),
                child: PageView(
                  onPageChanged: controller.onChange,
                  controller: controller.pageController,
                  children: controller.onBoardList
                      .map(
                        (e) => MyPage(
                          image: e.image,
                          width: size.width,
                          height: SizeUtils.scale(
                            450,
                            size.width,
                          ),
                          title: e.title,
                          description: e.description,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            MediaQuery.of(context).size.width,
          ),
          right: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            MediaQuery.of(context).size.width,
          ),
          bottom: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            MediaQuery.of(context).size.width,
          ),
        ),
        child: Obx(
          () => MyButton(
            title: controller.currentIndex.value != 2 ? "Next" : "Get Started",
            onTap: controller.onTapButton,
          ),
        ),
      ),
    );
  }
}
