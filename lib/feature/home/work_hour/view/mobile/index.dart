import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/async_widget/async_base_widget.dart';
import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:attendance_app/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/home/work_hour/controller/index.dart';
import 'package:attendance_app/feature/home/work_hour/widget/working_hour_card.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

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
      ),
      body: MyRefreshIndicator(
        onRefresh: controller.onRefresh,
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeUtils.scale(
                  AppSize.paddingHorizontalLarge,
                  MediaQuery.of(context).size.width,
                ),
                right: SizeUtils.scale(
                  AppSize.paddingHorizontalLarge,
                  MediaQuery.of(context).size.width,
                ),
                top: SizeUtils.scale(AppSize.paddingVerticalLarge, size.width),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(text: "Work Overview", style: BodyXlargeMedium),
                      Obx(
                        () => DateDropDown(
                          date: controller.selectDate.value,
                          size: size,
                          onTap: controller.onTapDate,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeUtils.scale(20, size.width)),
                  Obx(
                    () => MyAsyncWidget(
                      list: controller.staffs.value,
                      isLoading: controller.isLoading.value,
                      builderWidget: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.staffs.length,
                        itemBuilder: (context, index) {
                          final UserModel staff = controller.staffs[index];
                          final List<AttendanceModel> attendance =
                              controller.getAttendancesForStaff(staff);
                          final PositionModel position =
                              controller.getPositionForStaff(staff);
                          int? totalWorkMinute;
                          double? percentage;
                          if (attendance.isNotEmpty) {
                            totalWorkMinute = 0;
                            for (var attendance in attendance) {
                              totalWorkMinute = (totalWorkMinute ?? 0) +
                                  DateFormatter().calculateDurationInMinutes(
                                    attendance.checkInDateTime!,
                                    attendance.checkOutDateTime,
                                  );
                            }
                            percentage = (totalWorkMinute ?? 0) /
                                NavigationController.to.totalWorkMinutes.value;
                          }
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