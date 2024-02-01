import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/setting/choose_language/controller/index.dart';
import 'package:timesync360/feature/setting/choose_language/widget/language_button.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageViewMobile extends StatelessWidget {
  const ChangeLanguageViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeLanguageController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Language",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            MediaQuery.of(context).size.width,
          ),
          right: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            MediaQuery.of(context).size.width,
          ),
          top: SizeUtils.scale(AppSize.paddingVerticalLarge, size.width),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: "Choose your language",
              style: BodyXXlargeMedium,
            ),
            SizedBox(height: SizeUtils.scale(10, size.width)),
            MyText(
              text:
                  "Choose a language that suits your style and make your app journey uniquely yours. Whether it's Khmer or English, your preferences matter.",
              maxLines: 5,
              style: BodyMediumRegular.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            SizedBox(height: SizeUtils.scale(50, size.width)),
            ...List.generate(
              controller.language.value.length,
              (index) => Obx(
                () => LanguageButton(
                  title: controller.language.value[index].title,
                  imageFlag: controller.language.value[index].imageFlag,
                  isSelected: controller.isSelected.value[index],
                  onTap: () => controller.changeLanguage(
                    controller.language.value[index],
                    size,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
