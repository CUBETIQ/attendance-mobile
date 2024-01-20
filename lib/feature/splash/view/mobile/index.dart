import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/constants/image.dart';
import 'package:attendance_app/feature/splash/controller/index.dart';
import 'package:attendance_app/feature/splash/widgets/animated_text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';

class SplashViewMobile extends StatelessWidget {
  const SplashViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SplashController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: controller.animation,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    SizeUtils.scale(
                      AppSize.borderRadiusXLarge,
                      size.width,
                    ),
                  ),
                ),
                height: SizeUtils.scale(100, size.width),
                child: Image.asset(
                  ImageAssets.logoTimeSync360,
                ),
              ),
            ),
            const SizedBox(height: 30),
            AnimatedText(
              title: controller.title,
            )
          ],
        ),
      ),
    );
  }
}
