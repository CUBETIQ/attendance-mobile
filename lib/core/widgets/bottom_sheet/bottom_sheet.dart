import 'dart:io';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/widgets/button/button.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:timesync360/types/avatar_type.dart';
import 'package:timesync360/utils/pick_file_handler.dart';
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
          left: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
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
              style: AppFonts().bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text:
                  "You have successfully checked in of your present! Good luck and have a nice day!",
              style: AppFonts().bodyMediumRegular,
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
          left: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
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
              style: AppFonts().bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text:
                  "You have successfully checked out of your present! Good bye and have a good rest!",
              style: AppFonts().bodyMediumRegular,
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
          left: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
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
              style: AppFonts().bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: "Are you sure you want to log out?",
              style: AppFonts().bodyMediumRegular,
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
      height: SizeUtils.scaleMobile(400, size.width),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
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
              style: AppFonts().bodyLarge.copyWith(
                    color: titleColor,
                  ),
            ),
            SizedBox(height: size.height * 0.01),
            MyText(
              text: description ?? "Description",
              style: AppFonts().bodyMediumRegular,
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
      height: SizeUtils.scaleMobile(370, size.width),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
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
            SizedBox(height: SizeUtils.scaleMobile(40, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.edit_rounded,
              title: "Edit",
              onTap: onTapEdit,
            ),
            SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
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

void getEditDeleteViewBottomSheet(
  BuildContext context, {
  bool? isDismissible,
  required String image,
  void Function()? onTapDelete,
  void Function()? onTapEdit,
  void Function()? onTapView,
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
      height: SizeUtils.scaleMobile(435, size.width),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
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
            SizedBox(height: SizeUtils.scaleMobile(35, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.visibility_rounded,
              title: "View Detail",
              onTap: onTapView,
            ),
            SizedBox(height: SizeUtils.scaleMobile(5, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.edit_rounded,
              title: "Edit",
              onTap: onTapEdit,
            ),
            SizedBox(height: SizeUtils.scaleMobile(5, size.width)),
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

void getPickImageButtomSheet(
  BuildContext context, {
  bool? isDismissible,
  void Function(File file)? onTapGallery,
  void Function(String? image, File? file)? onTapAvatar,
  void Function(File file)? onTapCamera,
  String? firstButtonTitle,
  String? secondButtonTitle,
  IconData? firstButtonIcon,
  IconData? secondButtonIcon,
  IconData? thirdButtonIcon,
  String? avatarType,
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
      height: SizeUtils.scaleMobile(430, size.width),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.22,
              child: SvgPicture.asset(
                SvgAssets.gallery,
              ),
            ),
            SizedBox(height: SizeUtils.scaleMobile(40, size.width)),
            MyButton(
              isIconButton: true,
              icon: firstButtonIcon ?? Icons.photo_rounded,
              title: firstButtonTitle ?? "Open Gallery",
              onTap: () async {
                Get.back();
                final file = await PickFileHandler.openGallery();
                if (file != null) {
                  onTapGallery?.call(file);
                }
              },
            ),
            SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: thirdButtonIcon ?? Icons.camera_rounded,
              title: secondButtonTitle ?? "Open Camcera",
              onTap: () async {
                Get.back();
                final file = await PickFileHandler.openCamera();
                if (file != null) {
                  onTapCamera?.call(file);
                }
              },
            ),
            SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: secondButtonIcon ?? Icons.person_rounded,
              title: secondButtonTitle ?? "Default Avatar",
              onTap: () async {
                Get.back();
                File? file;
                final resultImage = await Get.toNamed(
                  Routes.AVATAR,
                  arguments: avatarType ?? AvatarType.profile,
                );
                if (resultImage != null) {
                  final image = resultImage;
                  file = null;
                  onTapAvatar?.call(image, file);
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}

void getPickIconButtomSheet(
  BuildContext context, {
  bool? isDismissible,
  void Function()? onTapGallery,
  void Function()? onTapAvatar,
  String? firstButtonTitle,
  String? secondButtonTitle,
  IconData? firstButtonIcon,
  IconData? secondButtonIcon,
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
      height: SizeUtils.scaleMobile(370, size.width),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.22,
              child: SvgPicture.asset(
                SvgAssets.gallery,
              ),
            ),
            SizedBox(height: SizeUtils.scaleMobile(40, size.width)),
            MyButton(
              isIconButton: true,
              icon: firstButtonIcon ?? Icons.photo_rounded,
              title: firstButtonTitle ?? "Open Gallery",
              onTap: onTapGallery,
            ),
            SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: secondButtonIcon ?? Icons.person_rounded,
              title: secondButtonTitle ?? "Default Avatar",
              onTap: onTapAvatar,
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
      height: SizeUtils.scaleMobile(430, size.width),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: SizeUtils.scaleMobile(AppSize().paddingTitleSmall, size.width),
        ),
        child: Column(
          children: [
            SizedBox(
              width: SizeUtils.scaleMobile(200, size.width),
              height: SizeUtils.scaleMobile(140, size.width),
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(height: SizeUtils.scaleMobile(40, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.key_rounded,
              title: "Change Password",
              onTap: onTapChangePassword,
            ),
            SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: Icons.edit_rounded,
              title: "Edit",
              onTap: onTapEdit,
            ),
            SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
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

void getPickAttachmentButtomSheet(
  BuildContext context, {
  bool? isDismissible,
  void Function(File file)? onTapGallery,
  void Function(File? file)? onTapFile,
  void Function(File file)? onTapCamera,
  String? firstButtonTitle,
  String? secondButtonTitle,
  IconData? firstButtonIcon,
  IconData? secondButtonIcon,
  IconData? thirdButtonIcon,
  String? avatarType,
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
      height: SizeUtils.scaleMobile(430, size.width),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          right: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          top: AppSize().paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.65,
              height: size.height * 0.22,
              child: SvgPicture.asset(
                SvgAssets.gallery,
              ),
            ),
            SizedBox(height: SizeUtils.scaleMobile(40, size.width)),
            MyButton(
              isIconButton: true,
              icon: firstButtonIcon ?? Icons.photo_rounded,
              title: firstButtonTitle ?? "Open Gallery",
              onTap: () async {
                Get.back();
                final file = await PickFileHandler.openGallery();
                if (file != null) {
                  onTapGallery?.call(file);
                }
              },
            ),
            SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: thirdButtonIcon ?? Icons.camera_rounded,
              title: secondButtonTitle ?? "Open Camcera",
              onTap: () async {
                Get.back();
                final file = await PickFileHandler.openCamera();
                if (file != null) {
                  onTapCamera?.call(file);
                }
              },
            ),
            SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
            MyButton(
              isIconButton: true,
              icon: secondButtonIcon ?? Icons.file_open_rounded,
              title: secondButtonTitle ?? "Open File",
              onTap: () async {
                Get.back();
                final file = await PickFileHandler.openFileFolder();
                onTapFile?.call(file);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
