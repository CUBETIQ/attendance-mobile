import 'package:timesync360/core/widgets/layout_builder/responsive_layout.dart';
import 'package:timesync360/feature/task/task_detail/view/mobile/index.dart';
import 'package:timesync360/feature/task/task_detail/view/tablet/index.dart';
import 'package:flutter/material.dart';

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: TaskDetailViewTablet(),
      mobile: TaskDetailViewMobile(),
    );
  }
}
