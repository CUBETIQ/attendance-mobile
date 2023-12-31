import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackBar(String title, String message,
    {SnackPosition? snackPosition, Color? bgColor}) {
  return Get.snackbar(
    title.trString,
    message.trString,
    titleText: Align(
      alignment: Alignment.topLeft,
      child: MyText(
        text: title,
        maxLines: 2,
        textAlign: TextAlign.left,
        style: BodyLargeMedium.copyWith(color: Colors.white),
      ),
    ),
    messageText: Align(
      alignment: Alignment.bottomLeft,
      child: MyText(
        maxLines: 3,
        text: message,
        textAlign: TextAlign.left,
        style: BodyMediumRegular.copyWith(color: Colors.white),
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

showSuccessSnackBar(String title, String message,
    {SnackPosition? snackPosition, Color? bgColor}) {
  return Get.snackbar(
    title.trString,
    message.trString,
    titleText: Align(
      alignment: Alignment.topLeft,
      child: MyText(
        text: title,
        maxLines: 2,
        textAlign: TextAlign.left,
        style: BodyLargeMedium.copyWith(color: Colors.white),
      ),
    ),
    messageText: Align(
      alignment: Alignment.bottomLeft,
      child: MyText(
        maxLines: 3,
        text: message,
        textAlign: TextAlign.left,
        style: BodyMediumRegular.copyWith(color: Colors.white),
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
