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
import 'package:timesync/utils/converter.dart';

class GenerateQRController extends GetxController {
  static GenerateQRController get to => Get.find();

  final isSharing = false.obs;
  final color = Rxn<Color>(null);
  final savedColor = Rxn<Color>(null);

  String link =
      "${DeepLink.app}/${toBase64('${OrganizationController.to.organization.value.name?.toLowerCase().replaceAll(' ', '_')}?lat=${OrganizationController.to.organization.value.location?.lat}&long=${OrganizationController.to.organization.value.location?.lng}')}";
  // String link =
  //     "${DeepLink.app}/${OrganizationController.to.organization.value.name?.toLowerCase().replaceAll(' ', '_')}?lat=${OrganizationController.to.organization.value.location?.lat}&long=${OrganizationController.to.organization.value.location?.lng}";

  ScreenshotController screenshotController = ScreenshotController();

  Future<void> onTapShare() async {
    if (isSharing.value == false) {
      isSharing.value = true;

      screenshotController.capture().then((value) async {
        if (value != null) {
          final file = await writeUint8ListToFile(
              value, "${AppConfig.appLocalPath}/image.png");
          onShare([XFile(file.path)]);
        } else {
          isSharing.value = false;
        }
      }).catchError((e) {
        isSharing.value = false;
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
    try {
      final box = Get.context!.findRenderObject() as RenderBox?;
      await Share.shareXFiles(files,
          text:
              'Hello, this QR code facilitates easy check-in and out for attendance purposes. Simply scan it to mark your presence. See you there!',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } finally {
      isSharing.value = false;
    }
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
