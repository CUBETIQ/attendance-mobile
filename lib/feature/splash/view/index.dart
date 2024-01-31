import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/splash/view/mobile/index.dart';
import 'package:timesync360/feature/splash/view/tablet/index.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: SplashViewTablet(),
      mobile: SplashViewMobile(),
    );
  }
}
