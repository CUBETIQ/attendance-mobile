import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/home/admin_leave_request/view/mobile/index.dart';
import 'package:timesync360/feature/home/admin_leave_request/view/tablet/index.dart';
import 'package:flutter/material.dart';

class AdminLeaveRequestView extends StatelessWidget {
  const AdminLeaveRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: AdminLeaveRequestViewTablet(),
      mobile: AdminLeaveRequestViewMobile(),
    );
  }
}
