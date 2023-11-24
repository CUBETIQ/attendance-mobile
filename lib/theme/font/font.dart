// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String fontFamily = 'Inter';

TextStyle generateTextStyle({
  FontWeight fontWeight = FontWeight.bold,
  double fontSize = 16,
}) {
  return TextStyle(
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    fontSize: fontSize,
    letterSpacing: 0.2,
  );
}

final TextStyle HeadingH1 = generateTextStyle(fontSize: 48.sp);
final TextStyle HeadingH2 = generateTextStyle(fontSize: 40.sp);
final TextStyle HeadingH3 = generateTextStyle(fontSize: 32.sp);
final TextStyle HeadingH4 = generateTextStyle(fontSize: 24.sp);
final TextStyle HeadingH5 = generateTextStyle(fontSize: 20.sp);

final TextStyle BodyXlarge = generateTextStyle(fontSize: 18.sp);
final TextStyle BodyLarge = generateTextStyle(fontSize: 16.sp);
final TextStyle BodyMedium = generateTextStyle(fontSize: 14.sp);
final TextStyle BodySmall = generateTextStyle(fontSize: 12.sp);
final TextStyle BodyXSmall = generateTextStyle(fontSize: 10.sp);
final TextStyle BodyXXSmall = generateTextStyle(fontSize: 8.sp);

final TextStyle BodyXlargeSemi =
    generateTextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600);
final TextStyle BodyLargeSemi =
    generateTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600);
final TextStyle BodyMediumSemi =
    generateTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);
final TextStyle BodySmallSemi =
    generateTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600);
final TextStyle BodyXSmallSemi =
    generateTextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600);
final TextStyle BodyXXSmallSemi =
    generateTextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600);

final TextStyle BodyXlargeMedium =
    generateTextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500);
final TextStyle BodyLargeMedium =
    generateTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500);
final TextStyle BodyMediumMedium =
    generateTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);
final TextStyle BodySmallMedium =
    generateTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500);
final TextStyle BodyXSmallMedium =
    generateTextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500);
final TextStyle BodyXXSmallMedium =
    generateTextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500);

final TextStyle BodyXlargeRegular =
    generateTextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400);
final TextStyle BodyLargeRegular =
    generateTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);
final TextStyle BodyMediumRegular =
    generateTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400);
final TextStyle BodySmallRegular =
    generateTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400);
final TextStyle BodyXSmallRegular =
    generateTextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400);
final TextStyle BodyXXSmallRegular =
    generateTextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400);
