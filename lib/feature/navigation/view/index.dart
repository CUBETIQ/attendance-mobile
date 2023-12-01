import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/navigation/view/mobile/index.dart';
import 'package:attendance_app/feature/navigation/view/tablet/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: NavigationViewTablet(),
      mobile: NavigationViewMobile(),
    );
  }
}
