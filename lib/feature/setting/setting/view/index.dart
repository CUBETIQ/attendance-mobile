import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/feature/setting/setting/controller/index.dart';
import 'package:timesync/feature/setting/setting/widget/setting_card_button.dart';
import 'package:timesync/feature/setting/setting/widget/theme_switch_button.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/utils/size_util.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Setting",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize().paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.scale(15, size.width)),
                child: MyText(
                  text: "Appearance",
                  style: AppFonts().bodyXlargeMedium,
                ),
              ),
              Column(
                children: [
                  Obx(
                    () => ThemeSwitchButton(
                      title: "Dark Mode",
                      description: "Enable dark mode.",
                      value: controller.isDarkMode.value,
                      onChanged: controller.changeTheme,
                    ),
                  ),
                  SettingCardButton(
                    leadingIcon: Icons.color_lens_rounded,
                    title: "Change Theme",
                    description: "Change the theme of the application.",
                    onTap: () => Get.toNamed(Routes.THEME),
                  ),
                ].withSpaceBetween(
                  height: SizeUtils.scale(5, size.width),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.scale(15, size.width)),
                child: MyText(
                  text: "Preferences",
                  style: AppFonts().bodyXlargeMedium,
                ),
              ),
              Column(
                children: [
                  SettingCardButton(
                    leadingIcon: Icons.language_rounded,
                    title: "Language",
                    description: "Change the language of the application.",
                    onTap: () => Get.toNamed(Routes.LANGUAGE),
                  ),
                  SettingCardButton(
                    leadingIcon: Icons.notifications_rounded,
                    title: "Notification",
                    description: "Set the notification of the application.",
                    onTap: () => Get.toNamed(Routes.NOTIFICATION_SETTING),
                  ),
                ].withSpaceBetween(
                  height: SizeUtils.scale(5, size.width),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
