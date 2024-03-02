import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/routes/app_pages.dart';

showSessionExpiredDialog() {
  return Get.dialog(
    barrierDismissible: false,
    Dialog(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) => false,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: "Session Expired",
                style: AppFonts().bodyLarge,
              ),
              const SizedBox(height: 5),
              MyText(
                text: "Your session has expired. Please login again.",
                style: AppFonts().bodyMediumRegular,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Get.offAllNamed(Routes.LOGIN),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(Get.context!).colorScheme.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: MyText(
                      text: "Confirm",
                      style: AppFonts().bodyMediumRegular.copyWith(
                            color: Theme.of(Get.context!).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

showPermissionDialog(
  String title,
  String content,
) {
  return Platform.isIOS
      ? Get.dialog(
          CupertinoAlertDialog(
            title: MyText(
              text: title,
              textAlign: TextAlign.center,
              style: AppFonts().bodyMediumMedium,
            ),
            content: MyText(
              text: content,
              maxLines: 4,
              style: AppFonts().bodySmallRegular,
            ),
            actions: [
              CupertinoDialogAction(
                child: MyText(
                  text: "Cancel",
                  style: AppFonts().bodyMediumRegular,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              CupertinoDialogAction(
                child: MyText(
                  text: "Setting",
                  style: AppFonts().bodyMediumRegular,
                ),
                onPressed: () async {
                  Get.back();
                  await openAppSettings();
                },
              )
            ],
          ),
        )
      : Get.dialog(
          AlertDialog(
            titlePadding: const EdgeInsets.only(
              top: 15,
              bottom: 5,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            actionsPadding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            title: MyText(
              text: title,
              textAlign: TextAlign.center,
              style: AppFonts().bodyLargeMedium,
            ),
            content: MyText(
              text: content,
              maxLines: 4,
              style: AppFonts().bodyMediumRegular,
            ),
            actions: <Widget>[
              TextButton(
                child: MyText(
                  text: "Cancel",
                  style: AppFonts().bodyMediumRegular,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(
                child: MyText(
                  text: "Setting",
                  style: AppFonts().bodyMediumRegular,
                ),
                onPressed: () async {
                  Get.back();
                  await openAppSettings();
                },
              )
            ],
          ),
        );
}
