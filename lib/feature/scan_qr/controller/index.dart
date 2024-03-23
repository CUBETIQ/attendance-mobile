import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:timesync/constants/deepLink.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/scan_qr/service/index.dart';
import 'package:timesync/utils/validator.dart';
import 'package:zxing2/qrcode.dart';

class ScanQRController extends GetxController {
  static ScanQRController get to => Get.find();

  final isSharing = false.obs;
  final openFlashlight = false.obs;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
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
          if (!scanned && !Validator.isValNull(scanData.code)) {
            await pausedCamera(controller);

            final orgName = NavigationController.to.organization.value.name
                    ?.toLowerCase()
                    .replaceAll(' ', '_') ??
                '';

            if (scanData.code?.contains(DeepLink.app) == true) {
              if (scanData.code?.contains(orgName) == true) {
                QRService().uploadQR(scanData.code!);
              } else {
                showWarningSnackBar('Invalid QR',
                    'The QR code you scanned does not belong to your organization. Please try again.');
              }
            } else {
              showWarningSnackBar('Invalid QR',
                  'You have scanned an invalid QR code that is not supported by TimeSync. Please try again.');
            }

            // Resume camera after showing the warning snack bar only if the condition for QR code is not met
            if (!(scanData.code?.contains(DeepLink.app) == true &&
                scanData.code?.contains(orgName) == true)) {
              Future.delayed(const Duration(seconds: 1), () {
                controller.resumeCamera();
              });
            }
          }
        },
        cancelOnError: true,
      );
    } catch (e) {
      controller.resumeCamera();
      log('Error: $e');
    }
  }

  Future<void> pausedCamera(QRViewController? controller) async {
    HapticFeedback.heavyImpact();
    await controller?.pauseCamera();
  }

  Future<void> uploadQR() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      final file = File(result.path);
      Uint8List bytes = file.readAsBytesSync();
      final image = img.decodeImage(bytes);
      if (image != null) {
        LuminanceSource source = RGBLuminanceSource(
            image.width,
            image.height,
            image
                .convert(numChannels: 4)
                .getBytes(order: img.ChannelOrder.rgba)
                .buffer
                .asInt32List());
        final bitmap = BinaryBitmap(HybridBinarizer(source));
        final reader = QRCodeReader();
        final barcode = reader.decode(bitmap);
        if (barcode.text.isNotEmpty) {
          if (barcode.text.contains(DeepLink.app) == true) {
            final orgName = NavigationController.to.organization.value.name
                    ?.toLowerCase()
                    .replaceAll(' ', '_') ??
                '';
            if (barcode.text.contains(orgName) == true) {
              try {
                await pausedCamera(qrController.value);
                await QRService().uploadQR(barcode.text);
              } finally {
                qrController.value?.resumeCamera();
              }
            } else {
              showWarningSnackBar('Invalid QR',
                  'The QR code you scanned does not belong to your organization. Please try again.');
            }
          } else {
            showWarningSnackBar('Invalid QR',
                'You have scanned an invalid QR code that is not supported by TimeSync. Please try again.');
          }
        }
      }
    }
  }
}
