import 'package:attendance_app/core/widgets/layout_builder/role_layout.dart';
import 'package:attendance_app/feature/report/view/mobile/admin_report_view.dart';
import 'package:attendance_app/feature/report/view/mobile/staff_report_view.dart';
import 'package:flutter/material.dart';

import '../../../navigation/controller/index.dart';

class ReportViewMobile extends StatelessWidget {
  const ReportViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleBaseLayOut(
      role: NavigationController.to.getUserRole,
      admin: const AdminReportViewMobile(),
      staff: const StaffReportViewMobile(),
    );
  }
}
