import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/auth/login/controller/index.dart';
import 'package:attendance_app/feature/auth/login/view/mobile/index.dart';
import 'package:attendance_app/feature/auth/login/view/tablet/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        tablet: LoginViewTablet(),
        mobile: LoginViewMobile(),
      ),
    );
  }
}
