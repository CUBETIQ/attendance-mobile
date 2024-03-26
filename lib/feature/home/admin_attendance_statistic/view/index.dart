import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/home/admin_attendance_statistic/controller/index.dart';

class AttendanceStatisticView extends StatelessWidget {
  const AttendanceStatisticView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AttendanceStatisticController.to;
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => MyAppBarTitle(
            title: controller.appBarTitle.value,
          ),
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
