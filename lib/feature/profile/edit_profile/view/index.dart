import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/profile/edit_profile/view/mobile/index.dart';
import 'package:timesync360/feature/profile/edit_profile/view/tablet/index.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: EditProfileViewTablet(),
      mobile: EditProfileViewMobile(),
    );
  }
}
