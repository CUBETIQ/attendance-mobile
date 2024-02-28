import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/qr_scan/view/mobile/index.dart';

import 'package:flutter/material.dart';
import 'package:timesync360/feature/qr_scan/view/tablet/index.dart';

class ScanQRView extends StatelessWidget {
  const ScanQRView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: ScanQRViewTablet(),
      mobile: ScanQRViewMobile(),
    );
  }
}
