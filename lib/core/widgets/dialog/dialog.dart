import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                style: AppStyles().bodyLarge,
              ),
              const SizedBox(height: 5),
              MyText(
                text: "Your session has expired. Please login again.",
                style: AppStyles().bodyMediumRegular,
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
                      style: AppStyles().bodyMediumRegular.copyWith(
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
              style: AppStyles().bodyMediumMedium,
            ),
            content: MyText(
              text: content,
              maxLines: 4,
              style: AppStyles().bodySmallRegular,
            ),
            actions: [
              CupertinoDialogAction(
                child: MyText(
                  text: "Cancel",
                  style: AppStyles().bodyMediumRegular,
                ),
                onPressed: () {},
              ),
              CupertinoDialogAction(
                child: MyText(
                  text: "Setting",
                  style: AppStyles().bodyMediumRegular,
                ),
                onPressed: () {},
              )
            ],
          ),
        )
      : Get.dialog(
          AlertDialog(
            title: new Text("Dialog Title"),
            content: new Text("This is my content"),
            actions: <Widget>[
              TextButton(
                child: Text("Yes"),
                onPressed: () {},
              ),
              TextButton(
                child: Text("No"),
                onPressed: () {},
              )
            ],
          ),
        );
}
