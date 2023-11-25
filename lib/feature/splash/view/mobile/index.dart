import 'package:attendance_app/config/svg.dart';
import 'package:attendance_app/feature/splash/controller/index.dart';
import 'package:attendance_app/feature/splash/widgets/test_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashViewMobile extends StatelessWidget {
  const SplashViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SplashController.to;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: controller.animation,
            child: SizedBox(
              width: 300,
              height: 150,
              child: SvgPicture.asset(
                logo,
              ),
            ),
          ),
          const SizedBox(height: 20),
          AnimatedText(
            title: controller.title,
          )
        ],
      ),
    );
  }
}
