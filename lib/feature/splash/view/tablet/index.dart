import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/feature/splash/controller/index.dart';
import 'package:timesync/feature/splash/widgets/animated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashViewTablet extends StatelessWidget {
  const SplashViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SplashController.to;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: controller.animation,
              child: SizedBox(
                width: 400,
                height: 250,
                child: SvgPicture.asset(
                  SvgAssets.logo,
                ),
              ),
            ),
            const SizedBox(height: 30),
            AnimatedText(
              title: controller.title,
              textStyle: AppFonts().bodyXXlargeMedium,
            )
          ],
        ),
      ),
    );
  }
}
