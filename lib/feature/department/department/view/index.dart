import 'package:timesync/core/widgets/layout_builder/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:timesync/feature/department/department/view/mobile/index.dart';
import 'package:timesync/feature/department/department/view/tablet/index.dart';

class DepartmentView extends StatelessWidget {
  const DepartmentView({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: DepartmentViewTablet(),
      mobile: DepartmentViewMobile(),
    );
  }
}
