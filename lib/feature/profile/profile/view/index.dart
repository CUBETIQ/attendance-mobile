import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/profile/profile/view/mobile/index.dart';
import 'package:attendance_app/feature/profile/profile/view/tablet/index.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: ProfileViewTablet(),
      mobile: ProfileViewMobile(),
    );
  }
}
