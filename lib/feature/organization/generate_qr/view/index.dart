import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/image.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/organization/generate_qr/controller/index.dart';
import 'package:timesync/feature/organization/organiziation/controller/index.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/validator.dart';

class GenerateQRView extends StatelessWidget {
  const GenerateQRView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GenerateQRController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const MyAppBarTitle(title: 'Generate QR'),
          centerTitle: true,
          leading: const MyBackButton(),
          automaticallyImplyLeading: false,
        ),
        body: Screenshot(
          controller: controller.screenshotController,
          child: Obx(() {
            return Container(
              width: size.width,
              color: controller.color.value ??
                  Theme.of(context).colorScheme.primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary,
                        width: 2,
                      ),
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(
                          SizeUtils.scale(24, size.width)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(SizeUtils.scale(24, size.width)),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeUtils.scale(12, size.width)),
                              child: Container(
                                alignment: Alignment.center,
                                height: SizeUtils.scale(80, size.width),
                                width: SizeUtils.scale(80, size.width),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  shape: BoxShape.circle,
                                  image: Validator.isValNull(
                                          OrganizationController
                                              .to.organization.value.image)
                                      ? const DecorationImage(
                                          image: AssetImage(
                                              ImageAssets.logotimesync),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: MyCacheImage(
                                  height: SizeUtils.scale(80, size.width),
                                  width: SizeUtils.scale(80, size.width),
                                  imageUrl: OrganizationController
                                      .to.organization.value.image,
                                  defaultImage: '',
                                  isRounded: true,
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: SizeUtils.scale(6, size.width)),
                            child: MyText(
                              text: OrganizationController
                                      .to.organization.value.name ??
                                  'TimeSync',
                              style:
                                  AppFonts().bodyLarge.copyWith(fontSize: 20),
                            ),
                          ),
                          MyText(
                            text: OrganizationController
                                    .to.organization.value.address ??
                                '',
                            style: AppFonts().bodyMediumRegular,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 10,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.all(SizeUtils.scale(12, size.width)),
                            child: QrImageView(
                              data: controller.link,
                              version: QrVersions.auto,
                              size: SizeUtils.scale(180, size.width),
                              // ignore: deprecated_member_use
                              foregroundColor:
                                  Theme.of(context).colorScheme.onBackground,
                              eyeStyle: QrEyeStyle(
                                  eyeShape: QrEyeShape.circle,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          MyText(
                            text: 'Scan Attendance',
                            style: AppFonts().bodyLarge.copyWith(fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    return controller.isSharing.value == true
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: EdgeInsets.only(
                                top: SizeUtils.scale(20, size.width)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildButton(
                                    onTap: () =>
                                        controller.onTapPickColor(context),
                                    svg: SvgAssets.color,
                                    context: context,
                                    size: size),
                                SizedBox(
                                    width: SizeUtils.scale(20, size.width)),
                                _buildButton(
                                    onTap: controller.onTapShare,
                                    svg: SvgAssets.share,
                                    context: context,
                                    size: size),
                              ],
                            ),
                          );
                  })
                ],
              ),
            );
          }),
        ));
  }

  Widget _buildButton(
      {void Function()? onTap,
      required String svg,
      required BuildContext context,
      required Size size}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: SizeUtils.scale(54, size.width),
        height: SizeUtils.scale(54, size.width),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Padding(
          padding: EdgeInsets.all(
            SizeUtils.scale(12, size.width),
          ),
          child: SvgPicture.asset(
            svg,
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onBackground, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
