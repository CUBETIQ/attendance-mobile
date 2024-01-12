import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/home/work_hour/view/mobile/index.dart';
import 'package:attendance_app/feature/home/work_hour/view/tablet/index.dart';
import 'package:flutter/material.dart';

class WorkingHourView extends StatelessWidget {
  const WorkingHourView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: WorkingHourViewTablet(),
      mobile: WorkingHourViewMobile(),
    );
  }
}
