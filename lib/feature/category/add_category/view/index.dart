import 'package:timesync/core/widgets/layout_builder/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:timesync/feature/category/add_category/view/mobile/index.dart';
import 'package:timesync/feature/category/add_category/view/tablet/index.dart';

class AddCategoryView extends StatelessWidget {
  const AddCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: AddCategoryViewTablet(),
      mobile: AddCategoryViewMobile(),
    );
  }
}
