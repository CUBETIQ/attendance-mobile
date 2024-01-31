import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/organization/organiziation/view/mobile/index.dart';
import 'package:timesync360/feature/organization/organiziation/view/tablet/index.dart';
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
