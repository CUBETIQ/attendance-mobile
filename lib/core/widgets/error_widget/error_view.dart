import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/lotties.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: SizeUtils.scale(300, size.width),
              child: Lottie.asset(
                LottieAssets.error404,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.scale(24, size.width),
                ),
                child: MyText(
                  text:
                      "Oh no! A problem occurred. Don't worry, our team has been notified and is working to fix it.",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: BodyXlargeMedium.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeUtils.scale(24, size.width)),
            MyButton(
              width: SizeUtils.scale(150, size.width),
              height: SizeUtils.scale(42, size.width),
              title: "Retry",
              onTap: () {
                Get.offNamed(Routes.SPLASH);
              },
            ),
          ],
        ),
      ),
    );
  }
}
