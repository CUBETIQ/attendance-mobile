import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/leave/add_leave/view/mobile/index.dart';
import 'package:attendance_app/feature/leave/add_leave/view/tablet/index.dart';
import 'package:flutter/material.dart';

class AddLeaveView extends StatelessWidget {
  const AddLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: AddLeaveViewTablet(),
      mobile: AddLeaveViewMobile(),
    );
  }
}
