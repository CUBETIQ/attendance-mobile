import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/leave/leave/view/mobile/index.dart';
import 'package:attendance_app/feature/leave/leave/view/tablet/index.dart';
import 'package:flutter/material.dart';

class LeaveView extends StatelessWidget {
  const LeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: LeaveViewTablet(),
      mobile: LeaveViewMobile(),
    );
  }
}
