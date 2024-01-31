import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/setting/choose_language/view/mobile/index.dart';
import 'package:timesync360/feature/setting/choose_language/view/tablet/index.dart';
import 'package:flutter/material.dart';

class ChangeLanguageView extends StatelessWidget {
  const ChangeLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: ChangeLanguageViewTablet(),
      mobile: ChangeLanguageViewMobile(),
    );
  }
}
