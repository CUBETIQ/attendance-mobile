import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/qr_scan/controller/index.dart';

class ScanQRViewMobile extends StatelessWidget {
  const ScanQRViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScanQRController.to;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(title: 'Scan QR'),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            overlay: QrScannerOverlayShape(
              overlayColor:
                  Theme.of(context).colorScheme.background.withOpacity(0.9),
              borderColor: Theme.of(context).colorScheme.primary,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
            key: controller.qrKey,
            onQRViewCreated: controller.onQRViewCreated,
          ),
          Transform.translate(
            offset: const Offset(0, -250),
            child: const MyText(
              text: 'Scan QR',
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -220),
            child: const MyText(
              text: 'Align frame with QR Code',
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 250),
            child: InkWell(
              onTap: () => controller.onTapFlashlight(),
              child: Obx(() => Icon(
                    controller.openFlashlight.value == true
                        ? Icons.flashlight_on_rounded
                        : Icons.flashlight_off_rounded,
                    color: Theme.of(context).colorScheme.primary.withOpacity(
                        controller.openFlashlight.value == true ? 1 : 0.7),
                    size: 50,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
