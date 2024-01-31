import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:timesync360/feature/position/add_position/view/mobile/index.dart';
import 'package:timesync360/feature/position/add_position/view/tablet/index.dart';

class AddPositionView extends StatelessWidget {
  const AddPositionView({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: AddPositionViewTablet(),
      mobile: AddPositionViewMobile(),
    );
  }
}
