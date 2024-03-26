import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/no_data/no_data.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/home/admin_attendance_statistic/controller/index.dart';
import 'package:timesync/feature/home/admin_attendance_statistic/widget/attendance_statistic_card.dart';
import 'package:timesync/utils/size_util.dart';

class AttendanceStatisticView extends StatelessWidget {
  const AttendanceStatisticView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AttendanceStatisticController.to;
    final size = MediaQuery.of(context).size;
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              SizeUtils.scale(AppSize().paddingHorizontalLarge, size.width),
        ),
        child: MyAsyncWidget(
          isLoading: false,
          list: controller.attendaces.value,
          noDataWidget: const MyNoData(),
          builderWidget: ListView.separated(
            itemCount: controller.attendaces.length,
            padding: EdgeInsets.only(
              top: SizeUtils.scale(20, size.width),
            ),
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(
              height: SizeUtils.scale(10, size.width),
            ),
            itemBuilder: (context, index) {
              final attendance = controller.attendaces[index];
              final staff = controller.getUser(attendance);
              return Obx(
                () => AttendanceStatisticCard(
                  staff: staff,
                  attendance: attendance,
                  isCheckOut: controller.appBarTitle.value == "Check out"
                      ? true
                      : false,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
