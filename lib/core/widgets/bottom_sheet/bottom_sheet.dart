import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

void getCheckInBottomSheet(BuildContext context,
    {bool? isDismissible, required String image}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50 * (size.width / 375.0)),
        topRight: Radius.circular(50 * (size.width / 375.0)),
      ),
    ),
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: size.height * 0.8,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSize.paddingHorizontalLarge,
          right: AppSize.paddingHorizontalLarge,
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
        topLeft: Radius.circular(50 * (size.width / 375.0)),
        topRight: Radius.circular(50 * (size.width / 375.0)),
      ),
    ),
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: size.height * 0.8,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSize.paddingHorizontalLarge,
          right: AppSize.paddingHorizontalLarge,
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

void getLogOutBottomSheet(
  BuildContext context, {
  bool? isDismissible,
  required String image,
  void Function()? onTapLogOut,
}) {
  final size = MediaQuery.of(context).size;
  Get.bottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50 * (size.width / 375.0)),
        topRight: Radius.circular(50 * (size.width / 375.0)),
      ),
    ),
    isDismissible: isDismissible ?? true,
    Container(
      width: size.width,
      height: size.height * 0.5,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSize.paddingHorizontalLarge,
          right: AppSize.paddingHorizontalLarge,
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
              text: "Log Out",
              style: BodyLarge,
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: "Are you sure you want to log out?",
              style: BodyMediumRegular,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyButton(
                      title: "Cancel",
                      onTap: () => Get.back(),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: MyButton(
                      title: "Confirm",
                      onTap: onTapLogOut,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}