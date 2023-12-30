import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/task/add_task/view/mobile/index.dart';
import 'package:attendance_app/feature/task/add_task/view/tablet/index.dart';
import 'package:flutter/material.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: AddTaskViewTablet(),
      mobile: AddTaskViewMobile(),
    );
  }
}
