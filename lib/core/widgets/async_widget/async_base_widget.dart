import 'package:attendance_app/core/widgets/loading/loading.dart';
import 'package:attendance_app/core/widgets/no_data/no_data.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';

class MyAsyncWidget extends StatelessWidget {
  final List<dynamic> list;
  final bool isLoading;
  final Widget builderWidget;
  final Widget? noDataWidget;

  const MyAsyncWidget({
    super.key,
    required this.list,
    required this.isLoading,
    required this.builderWidget,
    this.noDataWidget,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.only(top: SizeUtils.scale(40, size.width)),
        child: const MyLoading(),
      );
    } else if (list.isEmpty) {
      return noDataWidget ?? const MyNoData();
    } else {
      return builderWidget;
    }
  }
}
