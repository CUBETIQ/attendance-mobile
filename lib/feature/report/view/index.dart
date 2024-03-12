import 'package:timesync/core/widgets/layout_builder/role_layout.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/report/view/admin_report_view.dart';
import 'package:timesync/feature/report/view/staff_report_view.dart';
import 'package:flutter/material.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleBaseLayOut(
      role: NavigationController.to.getUserRole,
      admin: const AdminReportViewMobile(),
      staff: const StaffReportViewMobile(),
    );
  }
}
