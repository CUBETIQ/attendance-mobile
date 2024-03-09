import 'package:timesync/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync/feature/report/view/mobile/report_view.dart';
import 'package:timesync/feature/report/view/tablet/index.dart';
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
