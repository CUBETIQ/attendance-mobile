import 'package:timesync/core/widgets/layout_builder/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:timesync/feature/category/category/view/mobile/index.dart';
import 'package:timesync/feature/category/category/view/tablet/index.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: CategoryViewTablet(),
      mobile: CategoryViewMobile(),
    );
  }
}
