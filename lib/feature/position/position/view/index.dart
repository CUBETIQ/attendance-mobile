import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/position/position/view/mobile/index.dart';
import 'package:timesync360/feature/position/position/view/tablet/index.dart';
import 'package:flutter/material.dart';

class PositionView extends StatelessWidget {
  const PositionView({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: PositionViewTablet(),
      mobile: PositionViewMobile(),
    );
  }
}
