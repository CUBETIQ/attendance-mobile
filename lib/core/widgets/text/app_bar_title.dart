import 'package:timesync360/config/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBarTitle extends StatelessWidget {
  final String title;
  final TextStyle? style;

  const MyAppBarTitle({super.key, required this.title, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.tr,
      style: style ?? BodyXXlargeMedium,
    );
  }
}
