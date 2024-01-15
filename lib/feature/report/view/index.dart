import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/report/view/mobile/index.dart';
import 'package:attendance_app/feature/report/view/tablet/index.dart';
import 'package:flutter/material.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: ReportViewTablet(),
      mobile: ReportViewMobile(),
    );
  }
}
