import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/feature/setting/change_theme/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeThemeViewMobile extends StatelessWidget {
  const ChangeThemeViewMobile({super.key});

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
        elevation: 2,
      ),
      body: Container(),
    );
  }
}
