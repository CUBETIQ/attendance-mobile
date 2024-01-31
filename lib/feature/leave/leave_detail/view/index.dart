import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/leave/leave_detail/view/mobile/index.dart';
import 'package:timesync360/feature/leave/leave_detail/view/tablet/index.dart';
import 'package:flutter/material.dart';

class LeaveDetailView extends StatelessWidget {
  const LeaveDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: LeaveDetailViewTablet(),
      mobile: LeaveDetailViewMobile(),
    );
  }
}
