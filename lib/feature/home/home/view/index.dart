import 'package:timesync/core/widgets/layout_builder/role_layout.dart';
import 'package:timesync/feature/home/home/view/admin_home_view.dart';
import 'package:timesync/feature/home/home/view/staff_home_view.dart';
import 'package:flutter/material.dart';
import 'package:timesync/feature/navigation/controller/index.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleBaseLayOut(
      role: NavigationController.to.getUserRole,
      admin: const HomeAdminView(),
      staff: const HomeStaffView(),
    );
  }
}
