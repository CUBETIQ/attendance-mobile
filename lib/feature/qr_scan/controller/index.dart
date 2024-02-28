import 'package:get/get.dart';


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRController extends GetxController {
    static ScanQRController get to => Get.find();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final openFlashlight = false.obs;
  final qrController = Rx<QRViewController?>(null);
  Barcode? result;

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
    controller.scannedDataStream.listen(
      (scanData) {
        // if (FamilyAccountController.to.isFunctionRunning.value == false) {
        //   result = scanData;
        //   FamilyAccountController.to.isFunctionRunning.value = true;
        //   Timer(const Duration(seconds: 2), () {
        //     if (result != null) {
        //       if (result!.code?.contains('familyconnect') == true) {
        //         FamilyAccountController.to.findLink(
        //           code:
        //               result!.code!.replaceAll(RegExp('.*familyconnect/'), ''),
        //         );
        //       } else {
        //         _deBouncer.run(() async {
        //           FamilyAccountController.to.isFunctionRunning.value = false;
        //           showAlertSnackBar('Alert', 'QR Code is not correct');
        //         });
        //       }
        //     }
        //   });
        // }
      },
      cancelOnError: true,
    );
  }
}
