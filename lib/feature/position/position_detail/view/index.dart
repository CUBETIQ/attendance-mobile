import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:timesync360/feature/position/position_detail/view/mobile/index.dart';
import 'package:timesync360/feature/position/position_detail/view/tablet/index.dart';

class PositionDetailView extends StatelessWidget {
  const PositionDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: PositionDetailViewTablet(),
      mobile: PositionDetailViewMobile(),
    );
  }
}
