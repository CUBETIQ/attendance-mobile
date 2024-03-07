import 'package:timesync/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync/feature/auth/login/view/mobile/index.dart';
import 'package:timesync/feature/auth/login/view/tablet/index.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: LoginViewTablet(),
      mobile: LoginViewMobile(),
    );
  }
}
