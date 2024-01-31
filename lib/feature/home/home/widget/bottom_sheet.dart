import 'package:timesync360/config/app_size.dart';
import 'package:timesync360/config/font.dart';
import 'package:timesync360/core/widgets/button/button.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

void getCheckInBottomSheet(BuildContext context,
    {bool? isDismissible, required String image}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(SizeUtils.scale(50, size.width)),
        topRight: Radius.circular(SizeUtils.scale(50, size.width)),
      ),
    ),
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: SizeUtils.scale(size.height * 0.8, size.width),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            MediaQuery.of(context).size.width,
          ),
          right: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            MediaQuery.of(context).size.width,
          ),
          top: AppSize.paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.25,
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: "Successfully Checked In!",
              style: BodyLarge,
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text:
                  "You have successfully checked in of your present! Good luck and have a nice day!",
              style: BodyMediumRegular,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.05),
              child: MyButton(
                title: "Confirm",
                onTap: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void getCheckOutBottomSheet(BuildContext context,
    {bool? isDismissible, required String image}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(SizeUtils.scale(50, size.width)),
        topRight: Radius.circular(SizeUtils.scale(50, size.width)),
      ),
    ),
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: SizeUtils.scale(size.height * 0.8, size.width),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            MediaQuery.of(context).size.width,
          ),
          right: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            MediaQuery.of(context).size.width,
          ),
          top: AppSize.paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.25,
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: "Successfully Checked Out!",
              style: BodyLarge,
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text:
                  "You have successfully checked out of your present! Good bye and have a good rest!",
              style: BodyMediumRegular,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.05),
              child: MyButton(
                title: "Confirm",
                onTap: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
