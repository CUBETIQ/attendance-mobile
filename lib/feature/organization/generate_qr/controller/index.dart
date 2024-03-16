import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/constants/deepLink.dart';
import 'package:timesync/core/widgets/color_picker/color_picker_dialog.dart';
import 'package:timesync/feature/organization/organiziation/controller/index.dart';

class GenerateQRController extends GetxController {
  static GenerateQRController get to => Get.find();

  final isSharing = false.obs;
  final color = Rxn<Color>(null);
  final savedColor = Rxn<Color>(null);

  String link =
      "${DeepLink.app}/${OrganizationController.to.organization.value.name?.replaceAll(' ', '_')}";

  ScreenshotController screenshotController = ScreenshotController();

  Future<void> onTapShare() async {
    if (isSharing.value == false) {
      isSharing.value = true;
      screenshotController.capture().then((value) async {
        if (value != null) {
          final file = await writeUint8ListToFile(
              value, "${AppConfig.appLocalPath}/image.png");
          onShare([XFile(file.path)]);
        }
      });
    }
  }

  Future<File> writeUint8ListToFile(
      Uint8List uint8list, String filePath) async {
    final file = File(filePath);
    await file.writeAsBytes(uint8list);
    return file;
  }

  void onShare(
    List<XFile> files,
  ) async {
    final box = Get.context!.findRenderObject() as RenderBox?;
    await Share.shareXFiles(files,
        text: 'Hello, this is my payment check for purchasing a subscription.',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    isSharing.value = false;
  }

  void onTapPickColor(BuildContext context) {
    getColorPickerDialog(
      context: context,
      onChangeResult: (colorString, value) {
        color.value = value;
      },
      onCancel: () {
        color.value = savedColor.value ?? Theme.of(context).colorScheme.primary;
        Get.back();
      },
      onConfirm: () {
        savedColor.value = color.value;
        Get.back();
      },
    );
  }
}
