import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/employee/employee/view/mobile/index.dart';
import 'package:timesync360/feature/employee/employee/view/tablet/index.dart';
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
