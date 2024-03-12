import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/utils/size_util.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Get.back(closeOverlays: true),
      child: Icon(
        Icons.arrow_back_ios_rounded,
        color: Theme.of(context).colorScheme.onBackground,
        size: SizeUtils.scale(18, size.width),
      ),
    );
  }
}
