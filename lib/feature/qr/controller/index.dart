import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/constants/deepLink.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/image.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/qr/service/index.dart';
import 'package:timesync/types/role.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/validator.dart';

class QRController extends GetxController {
  static QRController get to => Get.find();

  final isSharing = false.obs;
  final openFlashlight = false.obs;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final qrController = Rx<QRViewController?>(null);

  String link =
      "${DeepLink.app}/${NavigationController.to.organization.value.name?.replaceAll(' ', '_')}";
  bool isAdmin = Get.arguments['role'] == Role.admin ? true : false;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void onClose() {
    qrController.value?.dispose();
    super.onClose();
  }

  Future<void> onTapShare() async {
    if (isSharing.value == false) {
      isSharing.value = true;
      screenshotController.captureFromWidget(buildQrView()).then((value) async {
        final file = await writeUint8ListToFile(
            value, "${AppConfig.appLocalPath}/image.png");
        onShare([XFile(file.path)]);
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

  void onTapFlashlight() async {
    await qrController.value?.toggleFlash();
    await qrController.value?.getFlashStatus().then((value) {
      openFlashlight.value = value!;
    });
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void onQRViewCreated(QRViewController controller) {
    qrController.value = controller;
    bool scanned = false;
    try {
      controller.scannedDataStream.listen(
        (scanData) async {
          showSuccessSnackBar("Here", scanned.toString());
          if (scanned == false) {
            HapticFeedback.heavyImpact();
            await controller.pauseCamera();
            QRService().initDeepLink();
          }
        },
        cancelOnError: true,
      );
    } catch (e) {
      log('Error: $e');
    }
  }

  Widget buildQrView() {
    final size = MediaQuery.of(Get.context!).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.scale(30, size.width),
              vertical: SizeUtils.scale(10, size.width)),
          child: Container(
            padding: EdgeInsets.all(SizeUtils.scale(10, size.width)),
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).colorScheme.primary,
              borderRadius:
                  BorderRadius.circular(SizeUtils.scale(10, size.width)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                QrImageView(
                  data: link,
                  version: QrVersions.auto,
                  size: SizeUtils.scale(180, size.width),
                  // ignore: deprecated_member_use
                  foregroundColor: Theme.of(Get.context!).colorScheme.onPrimary,
                  eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.circle,
                      color: Theme.of(Get.context!).colorScheme.primary),
                ),
                Container(
                  alignment: Alignment.center,
                  height: SizeUtils.scale(30, size.width),
                  width: SizeUtils.scale(30, size.width),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    image: !Validator.isValNull(
                            NavigationController.to.organization.value.image)
                        ? null
                        : const DecorationImage(
                            image: AssetImage(ImageAssets.logotimesync),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: Validator.isValNull(
                          NavigationController.to.organization.value.image)
                      ? const SizedBox.shrink()
                      : Image.network(
                          height: SizeUtils.scale(30, size.width),
                          width: SizeUtils.scale(30, size.width),
                          NavigationController.to.organization.value.image!,
                          fit: BoxFit.cover,
                        ),
                )
              ],
            ),
          ),
        ),
        MyText(
          text: NavigationController.to.organization.value.name ?? 'TimeSync',
          style: AppFonts().bodyLargeMedium.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
