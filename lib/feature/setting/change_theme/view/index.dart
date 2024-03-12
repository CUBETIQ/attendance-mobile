import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/setting/change_theme/controller/index.dart';
import 'package:timesync/feature/setting/change_theme/widget/color_card.dart';
import 'package:timesync/utils/size_util.dart';

class ChangeThemeView extends StatelessWidget {
  const ChangeThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeThemeController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Theme",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize().paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
            vertical: SizeUtils.scale(
              AppSize().paddingVerticalLarge,
              MediaQuery.of(context).size.width,
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Wrap(
              spacing: SizeUtils.scale(15, size.width),
              runSpacing: SizeUtils.scale(15, size.width),
              children: [
                ...List.generate(
                  controller.list.length,
                  (index) => ColorCard(
                    onTap: () => controller.onTap(index),
                    data: controller.list[index],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
