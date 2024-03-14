import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/database/isar/controller/local_storage_controller.dart';
import 'package:timesync/core/database/isar/model/local_storage_model.dart';
import 'package:timesync/core/database/isar/service/isar_service.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';

class ChangeThemeController extends GetxController {
  final list = MyColor.themeLists;

  final selectedTheme = Rxn<String>();

  LocalStorageModel? localStorageData = LocalStorageModel();

  @override
  void onInit() {
    super.onInit();
    initTheme();
  }

  Future<void> initTheme() async {
    AppConfig.setConfig(await LocalStorageController.getInstance().get());
    selectedTheme.value = AppConfig.getLocalData?.theme ?? MyColor.indigo;
  }

  Future<void> onTap(int index) async {
    getConfirmBottomSheet(
      Get.context!,
      image: SvgAssets.option,
      title: "Change Theme",
      titleColor: Theme.of(Get.context!).colorScheme.error,
      description:
          "Are you sure want to change theme? This will restart the app.",
      onTapConfirm: () async {
        localStorageData?.theme = list[index].color;
        await IsarService().saveLocalData(input: localStorageData);
        Restart.restartApp();
      },
    );
  }
}
