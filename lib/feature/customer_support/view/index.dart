import 'package:timesync/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync/feature/customer_support/view/mobile/index.dart';
import 'package:timesync/feature/customer_support/view/tablet/index.dart';
import 'package:flutter/material.dart';

class CustomerSupportView extends StatelessWidget {
  const CustomerSupportView({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: CustomerSupportViewTablet(),
      mobile: CustomerSupportViewMobile(),
    );
  }
}
