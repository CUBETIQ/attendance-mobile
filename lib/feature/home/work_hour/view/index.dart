import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/home/work_hour/controller/index.dart';
import 'package:timesync/feature/home/work_hour/widget/working_hour_card.dart';
import 'package:timesync/utils/size_util.dart';

class WorkingHourView extends StatelessWidget {
  const WorkingHourView({super.key});

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
      ),
      body: MyRefreshIndicator(
        onRefresh: controller.onRefresh,
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.scale(20, size.width)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeUtils.scale(12, size.width)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: "Overview",
                          style: AppFonts.TitleMedium.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                        Obx(
                          () => DateDropDown(
                            date: controller.selectDate.value,
                            size: size,
                            onTap: controller.onTapDate,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => MyAsyncWidget(
                      list: controller.staffs.value,
                      isLoading: controller.isLoading.value,
                      builderWidget: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.staffs.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height:
                              SizeUtils.scale(AppSize().paddingS6, size.width),
                        ),
                        itemBuilder: (context, index) {
                          final UserModel staff = controller.staffs[index];
                          final List<AttendanceModel> attendance =
                              controller.getAttendancesForStaff(staff);
                          final PositionModel position =
                              controller.getPositionForStaff(staff);
                          int? totalWorkMinute =
                              controller.calculateWorkHourPercentage(
                                  attendance)['totalWorkingMinute'];
                          double? percentage =
                              controller.calculateWorkHourPercentage(
                                  attendance)['percentage'];
                          return WorkHourCard(
                            staff: staff,
                            position: position,
                            percentage: percentage,
                            totalWorkMinute: totalWorkMinute,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
