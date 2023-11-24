import 'package:attendance_app/config/lotties.dart';
import 'package:attendance_app/feature/splash/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300.w,
          height: 150.h,
          child: Lottie.asset(
            lottieSplash,
            frameRate: FrameRate(controller.frameRate),
            repeat: false,
          ),
        ),
      ),
    );
  }
}
