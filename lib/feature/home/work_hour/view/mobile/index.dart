import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/feature/home/work_hour/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';

class WorkingHourViewMobile extends StatelessWidget {
  const WorkingHourViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = WorkHourController.to;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Working Hour",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SizeUtils.scale(15, size.width)),
            child: Icon(
              Icons.filter_list,
              color: Theme.of(context).colorScheme.onBackground,
              size: 25 * (size.width / 375.0),
            ),
          ),
        ],
      ),
    );
  }
}
