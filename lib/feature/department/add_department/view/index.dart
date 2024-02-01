import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:timesync360/feature/department/add_department/view/mobile/index.dart';
import 'package:timesync360/feature/department/add_department/view/tablet/index.dart';

class AddDepartmentView extends StatelessWidget {
  const AddDepartmentView({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: AddDepartmentViewTablet(),
      mobile: AddDepartmentViewMobile(),
    );
  }
}
