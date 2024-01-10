import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/color.dart';
import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/widgets/console/console.dart';
import 'package:attendance_app/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/extensions/string.dart';
import 'package:attendance_app/feature/home/home/controller/index.dart';
import 'package:attendance_app/feature/home/home/view/mobile/staff_home_view.dart';
import 'package:attendance_app/feature/home/home/widget/button_card.dart';
import 'package:attendance_app/feature/home/home/widget/date_dropdown.dart';
import 'package:attendance_app/feature/home/home/widget/linear_indicator.dart';
import 'package:attendance_app/feature/home/home/widget/pie_chart_card.dart';
import 'package:attendance_app/feature/home/home/widget/staff_attendance_card.dart';
import 'package:attendance_app/feature/home/home/widget/tab_bar.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class HomeAdminMobileView extends StatelessWidget {
  const HomeAdminMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.to;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        MyTabBar(
          tabs: controller.tabs.value,
          controller: controller.tabController,
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              SingleChildScrollView(
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
                    top: AppSize.paddingVerticalLarge,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: 'Overall Attendance'.trString,
                            style: BodyLargeMedium.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
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
                      SizedBox(height: SizeUtils.scale(20, size.width)),
                      Obx(
                        () => AttendancePieChartCard(
                          presentPercentage: controller.presentPercentage.value,
                          absentPercentage: controller.absentPercentage.value,
                          onLeavePercentage: controller.onLeavePercentage.value,
                          totalPresent: controller.totalChartPresent.value,
                          totalOnLeave: controller.totalChartLeave.value,
                          totalAbsent: controller.totalChartAbsent.value,
                          haveNoData: controller.haveNoData.value,
                        ),
                      ),
                      SizedBox(height: SizeUtils.scale(20, size.width)),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonCard(
                              icon: Icons.edit_document,
                              title: "Leave",
                              onTap: () {
                                Console.log("Leave", "Go to admin leave page");
                              },
                            ),
                          ),
                          SizedBox(width: SizeUtils.scale(20, size.width)),
                          Expanded(
                            child: ButtonCard(
                              icon: Icons.timer_rounded,
                              title: "Work Hour",
                              onTap: () {
                                Console.log("Task", "Go to admin task page");
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeUtils.scale(20, size.width)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyText(
                            text: 'Attendance Statistics'.trString,
                            style: BodyLargeMedium.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          const Spacer(),
                          Obx(
                            () => MyDropDownButton<String>(
                              width: SizeUtils.scale(130, size.width),
                              height: SizeUtils.scale(30, size.width),
                              buttonPadding: EdgeInsets.symmetric(
                                horizontal: SizeUtils.scale(10, size.width),
                              ),
                              dropdownWidth: SizeUtils.scale(130, size.width),
                              dropdownPadding: EdgeInsets.symmetric(
                                horizontal: SizeUtils.scale(10, size.width),
                                vertical: SizeUtils.scale(10, size.width),
                              ),
                              label: "Type",
                              hasLabel: false,
                              value: controller.selectedAttendanceType.value,
                              hint: "Choose role",
                              dropdownItems: controller.attendanceType
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: controller.onChanged,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeUtils.scale(20, size.width)),
                      Obx(
                        () => LinearIndicator(
                          title: "Early",
                          indicatorColor: MyColor.successColor,
                          percent: controller.earlyPercentage.value,
                          totalEmployees: controller.totalStaffs.value,
                          checkInEmployees: controller.totalCheckInEarly.value,
                          checkOutEmployees:
                              controller.totalCheckOutEarly.value,
                          isCheckIn: controller.isCheckIn.value,
                        ),
                      ),
                      SizedBox(height: SizeUtils.scale(10, size.width)),
                      Obx(
                        () => LinearIndicator(
                          title: "On Time",
                          indicatorColor: MyColor.pendingColor,
                          percent: controller.onTimePercentage.value,
                          totalEmployees: controller.totalStaffs.value,
                          checkInEmployees: controller.totalCheckInOnTime.value,
                          checkOutEmployees:
                              controller.totalCheckOutOnTime.value,
                          isCheckIn: controller.isCheckIn.value,
                        ),
                      ),
                      SizedBox(height: SizeUtils.scale(10, size.width)),
                      Obx(
                        () => LinearIndicator(
                          title: "Late",
                          indicatorColor: MyColor.errorColor,
                          percent: controller.latePercentage.value,
                          totalEmployees: controller.totalStaffs.value,
                          checkInEmployees: controller.totalCheckInLate.value,
                          checkOutEmployees: controller.totalCheckOutLate.value,
                          isCheckIn: controller.isCheckIn.value,
                        ),
                      ),
                      SizedBox(height: SizeUtils.scale(20, size.width)),
                      MyText(
                        text: 'Employee Attendance'.trString,
                        style: BodyLargeMedium.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(height: SizeUtils.scale(20, size.width)),
                      // Obx(
                      //   () => ListView.separated(
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     separatorBuilder: (context, index) =>
                      //         SizedBox(height: SizeUtils.scale(10, size.width)),
                      //     itemCount: controller.staffs.value.length,
                      //     itemBuilder: (context, index) {
                      //       final staff = controller.staffs.value[index];
                      //       final attendance = controller.staffAttendanceList
                      //           .firstWhere(
                      //               (element) => element.userId == staff.id,
                      //               orElse: () => AttendanceModel());
                      //       Console.log("Attendance", attendance.toJson());
                      //       return StaffAttendanceCard(
                      //         staff: staff,
                      //         attendance: attendance,
                      //       );
                      //     },
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              const HomeStaffMobileView(),
            ],
          ),
        ),
      ],
    );
  }
}
