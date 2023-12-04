import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/auth/activation/controller/index.dart';
import 'package:attendance_app/feature/auth/activation/view/mobile/index.dart';
import 'package:attendance_app/feature/auth/activation/view/tablet/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivationView extends GetView<ActivationController> {
  const ActivationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: ActivationViewTablet(),
      mobile: ActivationViewMobile(),
    );
  }
}
