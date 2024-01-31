import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/organization/edit_organization/view/mobile/index.dart';
import 'package:timesync360/feature/organization/edit_organization/view/tablet/index.dart';
import 'package:flutter/material.dart';

class EditOrganizationView extends StatelessWidget {
  const EditOrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: EditOrganizationViewTablet(),
      mobile: EditOrganizationViewMobile(),
    );
  }
}
