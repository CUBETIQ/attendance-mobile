import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: Get.back,
      child: Icon(
        Icons.arrow_back_ios_rounded,
        color: Theme.of(context).colorScheme.onBackground,
        size: 20 * (size.width / 375.0),
      ),
    );
  }
}
