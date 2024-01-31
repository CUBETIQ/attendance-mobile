import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/employee/add_employee/view/mobile/index.dart';
import 'package:timesync360/feature/employee/add_employee/view/tablet/index.dart';
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
