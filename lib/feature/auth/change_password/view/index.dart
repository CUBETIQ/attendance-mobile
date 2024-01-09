import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/auth/change_password/view/mobile/index.dart';
import 'package:attendance_app/feature/auth/change_password/view/tablet/index.dart';
import 'package:flutter/material.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: ChangePasswordViewTablet(),
      mobile: ChangePasswordViewMobile(),
    );
  }
}
