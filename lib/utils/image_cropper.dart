import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:timesync/utils/logger.dart';

class MyImageCropper {
  static Future<CroppedFile?> cropImage(
      {required String sourcePath,
      CropStyle? cropStyle,
      List<CropAspectRatioPreset>? aspectRatioPresets,
      List<PlatformUiSettings>? uiSettings}) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        cropStyle: cropStyle ?? CropStyle.circle,
        aspectRatioPresets: aspectRatioPresets ??
            [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
        uiSettings: uiSettings ??
            [
              AndroidUiSettings(
                  toolbarTitle: 'Crop',
                  toolbarColor: Theme.of(Get.context!).colorScheme.primary,
                  toolbarWidgetColor: Colors.white,
                  activeControlsWidgetColor:
                      Theme.of(Get.context!).colorScheme.primary,
                  statusBarColor: Theme.of(Get.context!).colorScheme.primary,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
              IOSUiSettings(
                title: 'Crop',
              ),
            ],
      );

      return croppedFile;
    } catch (e) {
      Logs.e('MyImageCropper.cropImage', error: e);
      return null;
    }
  }
}
