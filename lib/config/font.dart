// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String fontFamily = 'Inter';

double calculateFontSize(BuildContext context, double baseSize) {
  double screenWidth = MediaQuery.of(context).size.width;

  // Adjust the base size based on the screen width
  if (screenWidth >= 414) {
    // Larger than iPhone 12 Pro Max
    return baseSize * 1;
  } else if (screenWidth <= 375) {
    // Smaller than iPhone 11
    return baseSize * 0.85;
  } else {
    return baseSize;
  }
}

TextStyle generateTextStyle({
  FontWeight fontWeight = FontWeight.bold,
  double fontSize = 16,
}) {
  double adjustedFontSize = calculateFontSize(Get.context!, fontSize);
  return TextStyle(
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    fontSize: adjustedFontSize,
    letterSpacing: 0.2,
  );
}

final TextStyle HeadingH1 = generateTextStyle(fontSize: 48);
final TextStyle HeadingH2 = generateTextStyle(fontSize: 40);
final TextStyle HeadingH3 = generateTextStyle(fontSize: 32);
final TextStyle HeadingH4 = generateTextStyle(fontSize: 24);
final TextStyle HeadingH5 = generateTextStyle(fontSize: 20);

final TextStyle BodyXXXlarge = generateTextStyle(fontSize: 26);
final TextStyle BodyXXlarge = generateTextStyle(fontSize: 24);
final TextStyle BodyXlarge = generateTextStyle(fontSize: 18);
final TextStyle BodyLarge = generateTextStyle(fontSize: 16);
final TextStyle BodyMedium = generateTextStyle(fontSize: 14);
final TextStyle BodySmall = generateTextStyle(fontSize: 12);
final TextStyle BodyXSmall = generateTextStyle(fontSize: 10);
final TextStyle BodyXXSmall = generateTextStyle(fontSize: 8);

final TextStyle BodyXXXlargeSemi =
    generateTextStyle(fontSize: 24, fontWeight: FontWeight.w600);
final TextStyle BodyXXlargeSemi =
    generateTextStyle(fontSize: 22, fontWeight: FontWeight.w600);
final TextStyle BodyXlargeSemi =
    generateTextStyle(fontSize: 18, fontWeight: FontWeight.w600);
final TextStyle BodyLargeSemi =
    generateTextStyle(fontSize: 16, fontWeight: FontWeight.w600);
final TextStyle BodyMediumSemi =
    generateTextStyle(fontSize: 14, fontWeight: FontWeight.w600);
final TextStyle BodySmallSemi =
    generateTextStyle(fontSize: 12, fontWeight: FontWeight.w600);
final TextStyle BodyXSmallSemi =
    generateTextStyle(fontSize: 10, fontWeight: FontWeight.w600);
final TextStyle BodyXXSmallSemi =
    generateTextStyle(fontSize: 8, fontWeight: FontWeight.w600);

final TextStyle BodyXXXlargeMedium =
    generateTextStyle(fontSize: 24, fontWeight: FontWeight.w500);
final TextStyle BodyXXlargeMedium =
    generateTextStyle(fontSize: 22, fontWeight: FontWeight.w500);
final TextStyle BodyXlargeMedium =
    generateTextStyle(fontSize: 18, fontWeight: FontWeight.w500);
final TextStyle BodyLargeMedium =
    generateTextStyle(fontSize: 16, fontWeight: FontWeight.w500);
final TextStyle BodyMediumMedium =
    generateTextStyle(fontSize: 14, fontWeight: FontWeight.w500);
final TextStyle BodySmallMedium =
    generateTextStyle(fontSize: 12, fontWeight: FontWeight.w500);
final TextStyle BodyXSmallMedium =
    generateTextStyle(fontSize: 10, fontWeight: FontWeight.w500);
final TextStyle BodyXXSmallMedium =
    generateTextStyle(fontSize: 8, fontWeight: FontWeight.w500);

final TextStyle BodyXXXlargeRegular =
    generateTextStyle(fontSize: 24, fontWeight: FontWeight.w400);
final TextStyle BodyXXlargeRegular =
    generateTextStyle(fontSize: 22, fontWeight: FontWeight.w400);
final TextStyle BodyXlargeRegular =
    generateTextStyle(fontSize: 18, fontWeight: FontWeight.w400);
final TextStyle BodyLargeRegular =
    generateTextStyle(fontSize: 16, fontWeight: FontWeight.w400);
final TextStyle BodyMediumRegular =
    generateTextStyle(fontSize: 14, fontWeight: FontWeight.w400);
final TextStyle BodySmallRegular =
    generateTextStyle(fontSize: 12, fontWeight: FontWeight.w400);
final TextStyle BodyXSmallRegular =
    generateTextStyle(fontSize: 10, fontWeight: FontWeight.w400);
final TextStyle BodyXXSmallRegular =
    generateTextStyle(fontSize: 8, fontWeight: FontWeight.w400);
