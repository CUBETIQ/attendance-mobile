import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/home/controller/index.dart';
import 'package:attendance_app/feature/home/view/mobile/home_view.dart';
import 'package:attendance_app/feature/home/view/tablet/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: HomeViewTablet(),
      mobile: HomeViewMobile(),
    );
  }
}
