import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/auth/activation/view/mobile/index.dart';
import 'package:timesync360/feature/auth/activation/view/tablet/index.dart';
import 'package:flutter/material.dart';

class ActivationView extends StatelessWidget {
  const ActivationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: ActivationViewTablet(),
      mobile: ActivationViewMobile(),
    );
  }
}
