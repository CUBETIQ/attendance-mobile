import 'package:flutter/material.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/home/home/widget/tab_bar.dart';
import 'package:timesync/feature/home/summary_attendance/controller/index.dart';
import 'package:timesync/feature/home/summary_attendance/widget/absent_tab.dart';
import 'package:timesync/feature/home/summary_attendance/widget/leave_tab.dart';
import 'package:timesync/feature/home/summary_attendance/widget/present_tab.dart';

class SummaryAttendaceView extends StatelessWidget {
  const SummaryAttendaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SummaryAttendanceController.to;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Summary",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          MyTabBar(
            tabs: controller.tabs.value,
            controller: controller.tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: const [
                PresentTab(),
                LeaveTab(),
                AbsentTab(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
