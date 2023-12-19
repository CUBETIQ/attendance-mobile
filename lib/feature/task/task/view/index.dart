import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/task/task/controller/index.dart';
import 'package:attendance_app/feature/task/task/view/mobile/index.dart';
import 'package:attendance_app/feature/task/task/view/tablet/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskView extends GetView<TaskController> {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: TaskViewTablet(),
      mobile: TaskViewMobile(),
    );
  }
}
