import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/developer_mode/developer_mode.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/extensions/string.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Setting",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                    _buildSection(
                      title: "Appearance",
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
                      ],
                    ),
                    _buildSection(
                      title: "Preferences",
                      children: [
                        SettingCardButton(
                          leadingIcon: Icons.language_rounded,
                          title: "Language",
                          description:
                              "Change the language of the application.",
                          onTap: () => Get.toNamed(Routes.LANGUAGE),
                        ),
                        SettingCardButton(
                          leadingIcon: Icons.notifications_rounded,
                          title: "Notification",
                          description:
                              "Set the notification of the application.",
                          onTap: () => Get.toNamed(Routes.NOTIFICATION_SETTING),
                        ),
                      ],
                    ),
                    Obx(() {
                      return AppConfig.isDevMode.value == false
                          ? const SizedBox.shrink()
                          : _buildSection(
                              title: "Developer Mode",
                              children: [
                                SettingCardButton(
                                  leadingIcon: Icons.developer_mode_rounded,
                                  title: "Developer",
                                  description: "Access the developer features.",
                                  onTap: () => Get.toNamed(Routes.DEVELOPER_MODE),
                                ),
                              ],
                            );
                    }),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Obx(() {
                return AppConfig.isDevMode.value == false
                    ? const SizedBox.shrink()
                    : MyText(
                        text: 'Developer Mode',
                        style: AppFonts().bodyLargeMedium.copyWith(
                            color: Theme.of(context).colorScheme.primary));
              }),
              DeveloperMode(
                child: Obx(() => MyText(
                    text:
                        '${'Version'.trString}: ${AppConfig.packageInfo?.version ?? '0.0.0'}',
                    style: AppFonts().bodyMediumRegular.copyWith(
                        color: Theme.of(context).colorScheme.outline))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    final size = MediaQuery.of(Get.context!).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: SizeUtils.scale(15, size.width)),
          child: MyText(
            text: title,
            style: AppFonts().bodyXlargeMedium,
          ),
        ),
        Column(
          children: children.withSpaceBetween(
            height: SizeUtils.scale(5, size.width),
          ),
        )
      ],
    );
  }
}
