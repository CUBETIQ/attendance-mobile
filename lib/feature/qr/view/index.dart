import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/image.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/qr/controller/index.dart';
import 'package:timesync/utils/size_util.dart';

class MyQRView extends StatelessWidget {
  const MyQRView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = QRController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: MyAppBarTitle(
            title: controller.isAdmin ? 'Generate QR' : 'Scan QR'),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: controller.isAdmin
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      QrImageView(
                        data:
                            'timesyncmobile://myqr.timesync.com/${NavigationController.to.organization.value.name?.replaceAll(' ', '_')}/checkin',
                        version: QrVersions.auto,
                        size: SizeUtils.scale(180, size.width),
                        // ignore: deprecated_member_use
                        foregroundColor:
                            Theme.of(context).colorScheme.onBackground,
                        eyeStyle: QrEyeStyle(
                            eyeShape: QrEyeShape.circle,
                            color: Theme.of(context).colorScheme.primary),
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
                          image: const DecorationImage(
                            image: AssetImage(ImageAssets.logotimesync),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: MyCacheImage(
                          imageUrl:
                              NavigationController.to.organization.value.image,
                          defaultImage: '',
                          isRounded: false,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                QRView(
                  overlay: QrScannerOverlayShape(
                    overlayColor: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.9),
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
                  offset: const Offset(0, 250),
                  child: InkWell(
                    onTap: () => controller.onTapFlashlight(),
                    child: Obx(() => Icon(
                          controller.openFlashlight.value == true
                              ? Icons.flashlight_on_rounded
                              : Icons.flashlight_off_rounded,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(
                                  controller.openFlashlight.value == true
                                      ? 1
                                      : 0.7),
                          size: 50,
                        )),
                  ),
                ),
              ],
            ),
    );
  }
}
