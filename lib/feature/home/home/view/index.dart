import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/home/home/view/mobile/home_view.dart';
import 'package:attendance_app/feature/home/home/view/tablet/index.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: HomeViewTablet(),
      mobile: HomeViewMobile(),
    );
  }
}
