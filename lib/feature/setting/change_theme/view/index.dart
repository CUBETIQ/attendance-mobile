import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/setting/change_theme/view/mobile/index.dart';
import 'package:timesync360/feature/setting/change_theme/view/tablet/index.dart';
import 'package:flutter/material.dart';

class ChangeThemeView extends StatelessWidget {
  const ChangeThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: ChangeThemeViewTablet(),
      mobile: ChangeThemeViewMobile(),
    );
  }
}
