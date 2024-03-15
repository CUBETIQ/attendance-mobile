import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/qr/service/index.dart';
import 'package:timesync/types/role.dart';

class QRController extends GetxController {
  static QRController get to => Get.find();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final openFlashlight = false.obs;
  final qrController = Rx<QRViewController?>(null);

  bool isAdmin = Get.arguments['role'] == Role.admin ? true : false;

  @override
  void onClose() {
    qrController.value?.dispose();
    super.onClose();
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
}
