import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:timesync360/feature/department/department_detail/view/mobile/index.dart';
import 'package:timesync360/feature/department/department_detail/view/tablet/index.dart';

class DepartmentDetailView extends StatelessWidget {
  const DepartmentDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: DepartmentDetailViewTablet(),
      mobile: DepartmentDetailViewMobile(),
    );
  }
}
