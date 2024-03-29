import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackBar(String title, String message,
    {SnackPosition? snackPosition, Color? bgColor}) {
  if (!Get.isSnackbarOpen) {
    return Get.snackbar(
      title.trString,
      message.trString,
      titleText: Align(
        alignment: Alignment.topLeft,
        child: MyText(
          text: title,
          maxLines: 2,
          textAlign: TextAlign.left,
          style: AppFonts().bodyLargeMedium.copyWith(color: Colors.white),
        ),
      ),
      messageText: Align(
        alignment: Alignment.bottomLeft,
        child: MyText(
          maxLines: 3,
          text: message,
          textAlign: TextAlign.left,
          style: AppFonts().bodyMediumRegular.copyWith(color: Colors.white),
        ),
      ),
      icon: const Icon(
        Icons.error,
        color: Colors.white,
        size: 25,
      ),
      shouldIconPulse: false,
      maxWidth: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      snackPosition: snackPosition ?? SnackPosition.top,
      backgroundColor: bgColor ?? Colors.red,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      isDismissible: false,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}

showSuccessSnackBar(String title, String message,
    {SnackPosition? snackPosition, Color? bgColor}) {
  if (!Get.isSnackbarOpen) {
    return Get.snackbar(
      title.trString,
      message.trString,
      titleText: Align(
        alignment: Alignment.topLeft,
        child: MyText(
          text: title,
          maxLines: 2,
          textAlign: TextAlign.left,
          style: AppFonts().bodyLargeMedium.copyWith(color: Colors.white),
        ),
      ),
      messageText: Align(
        alignment: Alignment.bottomLeft,
        child: MyText(
          maxLines: 3,
          text: message,
          textAlign: TextAlign.left,
          style: AppFonts().bodyMediumRegular.copyWith(color: Colors.white),
        ),
      ),
      icon: const Icon(
        Icons.error,
        color: Colors.white,
        size: 25,
      ),
      shouldIconPulse: false,
      maxWidth: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      snackPosition: snackPosition ?? SnackPosition.top,
      backgroundColor: Colors.green,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      isDismissible: false,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}

showWarningSnackBar(String title, String message,
    {SnackPosition? snackPosition, Color? bgColor}) {
  if (!Get.isSnackbarOpen) {
    return Get.snackbar(
      title.trString,
      message.trString,
      titleText: Align(
        alignment: Alignment.topLeft,
        child: MyText(
          text: title,
          maxLines: 2,
          textAlign: TextAlign.left,
          style: AppFonts().bodyLargeMedium.copyWith(color: Colors.white),
        ),
      ),
      messageText: Align(
        alignment: Alignment.bottomLeft,
        child: MyText(
          maxLines: 3,
          text: message,
          textAlign: TextAlign.left,
          style: AppFonts().bodyMediumRegular.copyWith(color: Colors.white),
        ),
      ),
      icon: const Icon(
        Icons.warning_rounded,
        color: Colors.white,
        size: 25,
      ),
      shouldIconPulse: false,
      maxWidth: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      snackPosition: snackPosition ?? SnackPosition.top,
      backgroundColor: bgColor ?? Colors.orange,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      isDismissible: false,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}

showExitSnackBar(String title, String message,
    {SnackPosition? snackPosition, Color? bgColor}) {
  return !Get.isSnackbarOpen
      ? Get.snackbar(
          title.trString,
          '',
          titleText: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: MyText(
                text: title,
                textAlign: TextAlign.left,
                style:
                    AppFonts().bodyMediumRegular.copyWith(color: Colors.white)),
          ),
          messageText: const SizedBox.shrink(),
          maxWidth: 300,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          snackPosition: snackPosition ?? SnackPosition.bottom,
          backgroundColor: bgColor ?? Colors.grey.withOpacity(0.5),
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        )
      : const SizedBox.shrink();
}
