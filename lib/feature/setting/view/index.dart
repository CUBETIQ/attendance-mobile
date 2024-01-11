import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/setting/view/mobile/index.dart';
import 'package:attendance_app/feature/setting/view/tablet/index.dart';
import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: SettingViewTablet(),
      mobile: SettingViewMobile(),
    );
  }
}
