import 'package:timesync/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync/feature/home/summary_attendance/view/mobile/index.dart';
import 'package:timesync/feature/home/summary_attendance/view/tablet/index.dart';
import 'package:flutter/material.dart';

class SummaryAttendaceView extends StatelessWidget {
  const SummaryAttendaceView({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: SummaryAttendaceViewTablet(),
      mobile: SummaryAttendaceViewMobile(),
    );
  }
}
