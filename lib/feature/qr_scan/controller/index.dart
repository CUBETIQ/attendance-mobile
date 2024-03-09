import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRController extends GetxController {
  static ScanQRController get to => Get.find();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final openFlashlight = false.obs;
  final qrController = Rx<QRViewController?>(null);

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
          if (!scanned) {
            HapticFeedback.heavyImpact();
            await controller.pauseCamera();
          }
        },
        cancelOnError: true,
      );
    } finally {
      scanned = true;
      controller.resumeCamera();
    }
  }
}
