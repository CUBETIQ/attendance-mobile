import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/scan_qr/controller/index.dart';
import 'package:timesync/utils/size_util.dart';

class ScanQRView extends StatelessWidget {
  const ScanQRView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScanQRController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(title: 'Scan QR Attendance'),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
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
            child: MyText(
              text: 'Scan QR',
              style: AppFonts().bodyXlarge,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -220),
            child: MyText(
              text: 'Align frame with QR Code',
              style: AppFonts().bodyMediumRegular,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 260),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildButton(
                    onTap: () => controller.onTapFlashlight(),
                    context: context,
                    size: size,
                    widget: Obx(() => Icon(
                          controller.openFlashlight.value == true
                              ? Icons.flashlight_on_rounded
                              : Icons.flashlight_off_rounded,
                          color: Colors.white.withOpacity(
                              controller.openFlashlight.value == true
                                  ? 1
                                  : 0.7),
                          size: SizeUtils.scale(25, size.width),
                        )),
                    label: 'Flashlight'),
                SizedBox(width: SizeUtils.scale(50, size.width)),
                _buildButton(
                    onTap: () => controller.uploadQR(),
                    context: context,
                    size: size,
                    widget: SvgIcon(
                      icon: SvgAssets.qr,
                      width: SizeUtils.scale(54, size.width),
                      height: SizeUtils.scale(54, size.width),
                      color: Colors.white,
                    ),
                    label: 'Upload QR'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      {void Function()? onTap,
      required BuildContext context,
      required Widget widget,
      required Size size,
      required String label}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: SizeUtils.scale(54, size.width),
            height: SizeUtils.scale(54, size.width),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Padding(
              padding: EdgeInsets.all(
                SizeUtils.scale(12, size.width),
              ),
              child: widget,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeUtils.scale(5, size.width)),
            child: MyText(text: label, style: AppFonts().bodySmall),
          ),
        ],
      ),
    );
  }
}
