import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/database/isar/model/local_storage_model.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/utils/size_util.dart';

class DeveloperMode extends GetView<DeveloperModeController> {
  const DeveloperMode({super.key, required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DeveloperModeController());
    final size = MediaQuery.of(context).size;
    return Obx(() => Tooltip(
        message: AppConfig.isDevMode.value == true
            ? Get.locale.toString() == 'km'
                ? 'អ្នកត្រូវការចុច ${controller.clicksNeeded.value}ដងទៀតដើម្បីបិទដំណើរការមុខងារអ្នកអភិវឌ្ឍន៍'
                : 'You need ${controller.clicksNeeded.value} more clicks to deactivate the developer mode.'
                    .trString
            : Get.locale.toString() == 'km'
                ? 'អ្នកត្រូវការចុច ${controller.clicksNeeded.value}ដងទៀតដើម្បីដំណើរការមុខងារអ្នកអភិវឌ្ឍន៍'
                : 'You need ${controller.clicksNeeded.value} more clicks to activate the developer mode.'
                    .trString,
        margin:
            EdgeInsets.symmetric(horizontal: SizeUtils.scale(15, size.width)),
        textStyle: AppFonts()
            .bodyMediumRegular
            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        preferBelow: false,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(14)),
        triggerMode: TooltipTriggerMode.tap,
        onTriggered: controller.handleTripleClick,
        child: child));
  }
}

class DeveloperModeController extends GetxController {
  final clickCount = 0.obs;
  final clicksNeeded = 0.obs;
  final int requiredClicks = 5;
  final Duration timeLimit = const Duration(seconds: 5);
  Timer? clickTimer;

  final devUser = TextEditingController().obs;
  final devPass = TextEditingController().obs;

  final validator = Rxn<String>(null);

  Future<void> handleTripleClick() async {
    clickCount.value++;

    if (clickCount.value >= requiredClicks) {
      if (AppConfig.isDevMode.value == true) {
        AppConfig.isDevMode.value = false;
        AppConfig.getLocalData?.isDevMode = AppConfig.isDevMode.value;
        AppConfig.setConfig(AppConfig.getLocalData);
        await IsarService().saveLocalData(
          input: LocalStorageModel(
            isDevMode: AppConfig.isDevMode.value,
          ),
        );
      } else {
        onPressedDev();
      }
      resetClickCount();
    } else {
      clicksNeeded.value = requiredClicks - clickCount.value;
      clickTimer?.cancel();
      clickTimer = Timer(timeLimit, resetClickCount);
    }
  }

  void resetClickCount() {
    clickCount.value = 0;
  }

  @override
  void onClose() {
    clickTimer?.cancel();
    super.onClose();
  }

  Future<void> onPressedDev() async {
    // Add your logic here to enable the developer mode
    // ================================================
    // ---------------------- Here --------------------
    // ================================================
    AppConfig.isDevMode.value = true;
    AppConfig.getLocalData?.isDevMode = AppConfig.isDevMode.value;
    AppConfig.setConfig(AppConfig.getLocalData);
    await IsarService().saveLocalData(
      input: LocalStorageModel(
        isDevMode: AppConfig.isDevMode.value,
      ),
    );
  }

  Future<void> devLogin() async {
    if (devUser.value.text.isEmpty && devPass.value.text.isEmpty) {
      validator.value = "Please fill in all the fields";

      return;
    } else if (devUser.value.text.isEmpty) {
      validator.value = "Please fill in username!";

      return;
    } else if (devPass.value.text.isEmpty) {
      validator.value = "Please fill in password!";
      return;
    }

    // try {
    //   final data = await AuthService.devLogin(
    //       username: devUser.value.text, password: devPass.value.text);
    //   if (data?.hasError == true) {
    //     final message = data?.error?.message ?? 'Failed to login';
    //     Logs.e(message);
    //     showErrorSnackBar('Error', message);
    //   }
    //   if (data?.data != null) {
    //     String? token = data?.data;
    //     devPass.value.clear();
    //     devUser.value.clear();
    //     Get.back();
    //   }
    // }
  }
}
