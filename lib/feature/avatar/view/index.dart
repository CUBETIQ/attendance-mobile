import 'package:timesync/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync/feature/avatar/view/mobile/index.dart';
import 'package:timesync/feature/avatar/view/tablet/index.dart';
import 'package:flutter/material.dart';

class AvatarView extends StatelessWidget {
  const AvatarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: AvatarViewTablet(),
      mobile: AvatarViewMobile(),
    );
  }
}
