import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/onboard/view/mobile/index.dart';
import 'package:attendance_app/feature/onboard/view/tablet/index.dart';
import 'package:flutter/material.dart';

class OnBoardView extends StatelessWidget {
  const OnBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: OnBoardViewTablet(),
      mobile: OnBoardViewMobile(),
    );
  }
}
