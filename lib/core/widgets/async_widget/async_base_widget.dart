import 'package:attendance_app/core/widgets/loading/loading.dart';
import 'package:attendance_app/core/widgets/no_data/no_data.dart';
import 'package:flutter/material.dart';

class MyAsyncWidget extends StatelessWidget {
  final List<dynamic> list;
  final bool isLoading;
  final Widget builderWidget;

  const MyAsyncWidget({
    super.key,
    required this.list,
    required this.isLoading,
    required this.builderWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const MyLoading();
    } else if (list.isEmpty) {
      return const MyNoData();
    } else {
      return builderWidget;
    }
  }
}
