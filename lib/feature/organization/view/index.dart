import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/organization/view/mobile/index.dart';
import 'package:attendance_app/feature/organization/view/tablet/index.dart';
import 'package:flutter/material.dart';

class OrganizationView extends StatelessWidget {
  const OrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: OrganizationViewTablet(),
      mobile: OrganizationViewMobile(),
    );
  }
}
