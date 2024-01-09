import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
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
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
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
              text: "You Have Checked In!",
              style: BodyLarge.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
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
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
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
              text: "You Have Checked Out!",
              style: BodyLarge.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
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
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
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
              text: "Log Out",
              style: BodyLarge.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
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
                      backgroundColor: Theme.of(context).colorScheme.error,
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

void getConfirmBottomSheet(
  BuildContext context, {
  bool? isDismissible,
  required String image,
  void Function()? onTapConfirm,
  String? title,
  String? description,
  Color? titleColor,
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
      height: SizeUtils.scale(400, size.width),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
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
              text: title ?? "Title",
              style: BodyLarge.copyWith(
                color: titleColor,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: description ?? "Description",
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
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: MyButton(
                      title: "Confirm",
                      onTap: onTapConfirm,
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

void getEditAndDeleteBottomSheet(
  BuildContext context, {
  bool? isDismissible,
  required String image,
  void Function()? onTapDelete,
  void Function()? onTapEdit,
  String? title,
  String? description,
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
      height: SizeUtils.scale(370, size.width),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize.paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.22,
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(height: SizeUtils.scale(40, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.edit_rounded,
              title: "Edit",
              onTap: onTapEdit,
            ),
            SizedBox(height: SizeUtils.scale(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.delete_rounded,
              title: "Delete",
              onTap: onTapDelete,
            ),
          ],
        ),
      ),
    ),
  );
}

void getOptionsBottomSheet(
  BuildContext context, {
  bool? isDismissible,
  required String image,
  void Function()? onTapChangePassword,
  void Function()? onTapDelete,
  void Function()? onTapEdit,
  String? title,
  String? description,
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
      height: SizeUtils.scale(430, size.width),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
          ),
          top: SizeUtils.scale(AppSize.paddingTitleSmall, size.width),
        ),
        child: Column(
          children: [
            SizedBox(
              width: SizeUtils.scale(200, size.width),
              height: SizeUtils.scale(140, size.width),
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(height: SizeUtils.scale(40, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.key_rounded,
              title: "Change Password",
              onTap: onTapChangePassword,
            ),
            SizedBox(height: SizeUtils.scale(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.edit_rounded,
              title: "Edit",
              onTap: onTapEdit,
            ),
            SizedBox(height: SizeUtils.scale(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.delete_rounded,
              title: "Delete",
              onTap: onTapDelete,
            ),
          ],
        ),
      ),
    ),
  );
}
