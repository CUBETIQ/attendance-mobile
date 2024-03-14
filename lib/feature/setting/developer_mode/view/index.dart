import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/setting/setting/widget/setting_card_button.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/utils/size_util.dart';

class DeveloperModeView extends StatelessWidget {
  const DeveloperModeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Developer Setting",
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
                SettingCardButton(
                  leadingIcon: Icons.perm_device_info_rounded,
                  title: "Device Info",
                  description: "Show device information.",
                  onTap: () => Get.toNamed(Routes.DEVICE_INFO),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
