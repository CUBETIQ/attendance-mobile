import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/staff/add_staff/view/mobile/index.dart';
import 'package:attendance_app/feature/staff/add_staff/view/tablet/index.dart';
import 'package:flutter/material.dart';

class AddStaffView extends StatelessWidget {
  const AddStaffView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: AddStaffViewTablet(),
      mobile: AddStaffViewMobile(),
    );
  }
}
