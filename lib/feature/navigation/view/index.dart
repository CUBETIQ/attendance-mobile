import 'package:timesync/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync/feature/navigation/view/mobile/index.dart';
import 'package:timesync/feature/navigation/view/tablet/index.dart';
import 'package:flutter/material.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: NavigationViewTablet(),
      mobile: NavigationViewMobile(),
    );
  }
}
