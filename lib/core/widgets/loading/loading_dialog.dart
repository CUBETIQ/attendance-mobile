import 'package:timesync/constants/font.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../text/text.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  void show({required Size size, required String title}) {
    Get.dialog(
      Center(
        child: Container(
          width: SizeUtils.scaleMobile(240, size.width),
          height: SizeUtils.scaleMobile(60, size.width),
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scaleMobile(20, size.width),
          ),
          decoration: BoxDecoration(
            color: Theme.of(Get.context!).colorScheme.background,
            borderRadius: BorderRadius.circular(
              SizeUtils.scaleMobile(24, size.width),
            ),
          ),
          child: Material(
            child: Row(
              children: [
                MyText(
                  text: title,
                  style: AppFonts().bodyLargeMedium,
                ),
                const Spacer(),
                LoadingAnimationWidget.flickr(
                  leftDotColor: Theme.of(Get.context!).colorScheme.onBackground,
                  rightDotColor: Theme.of(Get.context!).colorScheme.primary,
                  size: SizeUtils.scaleMobile(40, size.width),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void dismiss() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder, as the actual content is shown using Get.dialog
  }
}
