import 'package:timesync/core/widgets/layout_builder/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:timesync/feature/profile/earn_point/view/mobile/index.dart';
import 'package:timesync/feature/profile/earn_point/view/tablet/index.dart';

class EarnPointView extends StatelessWidget {
  const EarnPointView({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: EarnPointViewTablet(),
      mobile: EarnPointViewMobile(),
    );
  }
}
