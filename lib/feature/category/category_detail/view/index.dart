import 'package:timesync/core/widgets/layout_builder/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:timesync/feature/category/category_detail/view/mobile/index.dart';
import 'package:timesync/feature/category/category_detail/view/tablet/index.dart';

class CategoryDetailView extends StatelessWidget {
  const CategoryDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: CategoryDetailViewTablet(),
      mobile: CategoryDetailViewMobile(),
    );
  }
}
