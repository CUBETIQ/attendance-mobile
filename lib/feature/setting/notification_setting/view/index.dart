import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/setting/notification_setting/controller/index.dart';
import 'package:timesync/feature/setting/setting/widget/theme_switch_button.dart';
import 'package:timesync/utils/size_util.dart';

class NotificationSettingView extends StatelessWidget {
  const NotificationSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Notification Setting",
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
              size.width,
            ),
          ),
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: SizeUtils.scale(15, size.width)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => ThemeSwitchButton(
                    title: "Enable Notification",
                    description: "Enable notification for this app.",
                    icon: Icons.notifications_active_rounded,
                    value: controller.isEnableNotification.value,
                    onChanged: controller.updateNotification,
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
