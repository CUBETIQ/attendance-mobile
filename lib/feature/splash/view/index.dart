import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/splash/controller/index.dart';
import 'package:attendance_app/feature/splash/view/mobile/index.dart';
import 'package:attendance_app/feature/splash/view/tablet/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        tablet: SplashViewTablet(),
        mobile: SplashViewMobile(),
      ),
    );
  }
}
