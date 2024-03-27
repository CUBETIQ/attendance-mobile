import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/card/empty_card_with_height.dart';
import 'package:timesync/core/widgets/no_data/empty_state.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/home/admin_attendance_statistic/controller/index.dart';
import 'package:timesync/feature/home/home/widget/staff_attendance_card.dart';
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
            title: controller.appBarTitle.value.replaceAll("-", " "),
          ),
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: controller.attendances.value.isEmpty
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  SizeUtils.scale(AppSize().paddingHorizontalLarge, size.width),
            ),
            child: MyAsyncWidget(
              isLoading: false,
              list: controller.attendances.value,
              noDataWidget: const MyEmptyState(),
              builderWidget: ListView.separated(
                shrinkWrap: true,
                itemCount: controller.attendances.length,
                padding: EdgeInsets.only(
                  top: SizeUtils.scale(20, size.width),
                ),
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(
                  height: SizeUtils.scale(10, size.width),
                ),
                itemBuilder: (context, index) {
                  final staff = controller.getUser()[index];
                  final attendance = controller.backUpAttendaces
                      .where((element) => element.userId == staff.id)
                      .toList();
                  return StaffAttendanceCard(
                    staff: staff,
                    attendance: attendance,
                  );
                },
              ),
            ),
          ),
          const MyBottomPaddingCard(),
        ],
      ),
    );
  }
}
