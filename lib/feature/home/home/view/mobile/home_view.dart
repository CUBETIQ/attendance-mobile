import 'package:attendance_app/core/widgets/layout_builder/role_layout.dart';
import 'package:attendance_app/feature/home/home/view/mobile/admin_home_view.dart';
import 'package:attendance_app/feature/home/home/view/mobile/staff_home_view.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:flutter/material.dart';

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleBaseLayOut(
      role: NavigationController.to.getUserRole,
      admin: const HomeAdminMobileView(),
      staff: const HomeStaffMobileView(),
    );
  }
}
