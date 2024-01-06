import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/staff/staff/view/mobile/index.dart';
import 'package:attendance_app/feature/staff/staff/view/tablet/index.dart';
import 'package:flutter/material.dart';

class StaffView extends StatelessWidget {
  const StaffView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: StaffViewTablet(),
      mobile: StaffViewMobile(),
    );
  }
}
