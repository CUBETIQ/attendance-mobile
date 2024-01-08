import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/staff/staff_detail/view/mobile/index.dart';
import 'package:attendance_app/feature/staff/staff_detail/view/tablet/index.dart';
import 'package:flutter/material.dart';

class StaffDetailView extends StatelessWidget {
  const StaffDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: StaffDetailViewTablet(),
      mobile: StaffDetailViewMobile(),
    );
  }
}
