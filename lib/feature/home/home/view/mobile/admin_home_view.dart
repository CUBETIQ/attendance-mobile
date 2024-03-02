import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/constants/color.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync360/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync360/core/widgets/no_data/no_data.dart';
import 'package:timesync360/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/extensions/string.dart';
import 'package:timesync360/feature/home/home/controller/index.dart';
import 'package:timesync360/feature/home/home/view/mobile/staff_home_view.dart';
import 'package:timesync360/feature/home/home/widget/button_card.dart';
import 'package:timesync360/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:timesync360/feature/home/home/widget/linear_indicator.dart';
import 'package:timesync360/feature/home/home/widget/pie_chart_card.dart';
import 'package:timesync360/feature/home/home/widget/staff_attendance_card.dart';
import 'package:timesync360/feature/home/home/widget/tab_bar.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              MyRefreshIndicator(
                onRefresh: controller.initAdminFunction,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeUtils.scaleMobile(
                        AppSize().paddingHorizontalLarge,
                        size.width,
                      ),
                      right: SizeUtils.scaleMobile(
                        AppSize().paddingHorizontalLarge,
                        size.width,
                      ),
                      top: SizeUtils.scaleMobile(
                          AppSize().paddingVerticalLarge, size.width),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              text: 'Overall Attendance',
                              style: AppFonts().bodyLargeMedium.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
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
                        SizedBox(height: SizeUtils.scaleMobile(20, size.width)),
                        Obx(
                          () => AttendancePieChartCard(
                            onTap: () => Get.toNamed(
                              Routes.ADMIN_SUMMARY_ATTENDANCE,
                              arguments: {
                                "staffs": controller.staffs.value,
                                "attendances":
                                    controller.staffAttendanceList.value,
                                "startDate": controller.startOfDay.value,
                                "endDate": controller.endOfDay.value,
                              },
                            ),
                            presentPercentage:
                                controller.presentPercentage.value,
                            absentPercentage: controller.absentPercentage.value,
                            onLeavePercentage:
                                controller.onLeavePercentage.value,
                            totalPresent: controller.totalChartPresent.value,
                            totalOnLeave: controller.totalChartLeave.value,
                            totalAbsent: controller.totalChartAbsent.value,
                            haveNoData: controller.haveNoData.value,
                          ),
                        ),
                        SizedBox(height: SizeUtils.scaleMobile(20, size.width)),
                        Row(
                          children: [
                            Expanded(
                              child: ButtonCard(
                                icon: Icons.edit_document,
                                title: "Leave",
                                onTap: () => Get.toNamed(
                                  Routes.ADMIN_LEAVE_REQUEST,
                                  arguments: controller.staffs.value,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: SizeUtils.scaleMobile(20, size.width)),
                            Expanded(
                              child: ButtonCard(
                                icon: Icons.timer_rounded,
                                title: "Work Hour",
                                onTap: () => Get.toNamed(
                                  Routes.WORKING_HOUR,
                                  arguments: {
                                    "staffs": controller.staffs.value,
                                    "attendances":
                                        controller.staffAttendanceList.value,
                                    "positions": controller.positionList.value,
                                    "date": controller.selectDate.value,
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeUtils.scaleMobile(20, size.width)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                              text: 'Attendance Statistic',
                              style: AppFonts().bodyLargeMedium.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                            const Spacer(),
                            Obx(
                              () => MyDropDownButton<String>(
                                width: SizeUtils.scaleMobile(130, size.width),
                                height: SizeUtils.scaleMobile(30, size.width),
                                isRoundedCorner: true,
                                buttonPadding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeUtils.scaleMobile(10, size.width),
                                ),
                                dropdownPadding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeUtils.scaleMobile(10, size.width),
                                  vertical:
                                      SizeUtils.scaleMobile(10, size.width),
                                ),
                                label: "Type",
                                hasLabel: false,
                                value: controller.selectedAttendanceType.value,
                                hint: "Choose role",
                                dropdownItems: controller.attendanceType
                                    .map(
                                      (e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e.trString),
                                      ),
                                    )
                                    .toList(),
                                onChanged: controller.onChanged,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeUtils.scaleMobile(20, size.width)),
                        Obx(
                          () => LinearIndicator(
                            title: "Early",
                            indicatorColor: MyColor.successColor,
                            percent: controller.earlyPercentage.value,
                            totalEmployees: controller.totalStaffs.value,
                            checkInEmployees:
                                controller.totalCheckInEarly.value,
                            checkOutEmployees:
                                controller.totalCheckOutEarly.value,
                            isCheckIn: controller.isCheckIn.value,
                          ),
                        ),
                        SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
                        Obx(
                          () => LinearIndicator(
                            title: "On Time",
                            indicatorColor: MyColor.pendingColor,
                            percent: controller.onTimePercentage.value,
                            totalEmployees: controller.totalStaffs.value,
                            checkInEmployees:
                                controller.totalCheckInOnTime.value,
                            checkOutEmployees:
                                controller.totalCheckOutOnTime.value,
                            isCheckIn: controller.isCheckIn.value,
                          ),
                        ),
                        SizedBox(height: SizeUtils.scaleMobile(10, size.width)),
                        Obx(
                          () => LinearIndicator(
                            title: "Late",
                            indicatorColor: MyColor.errorColor,
                            percent: controller.latePercentage.value,
                            totalEmployees: controller.totalStaffs.value,
                            checkInEmployees: controller.totalCheckInLate.value,
                            checkOutEmployees:
                                controller.totalCheckOutLate.value,
                            isCheckIn: controller.isCheckIn.value,
                          ),
                        ),
                        SizedBox(height: SizeUtils.scaleMobile(20, size.width)),
                        MyText(
                          text: 'Employee Attendance'.trString,
                          style: AppFonts().bodyLargeMedium.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        SizedBox(height: SizeUtils.scaleMobile(20, size.width)),
                        Obx(
                          () => MyAsyncWidget(
                            isLoading: controller.isLoadingList.value,
                            list: controller.staffAttendanceList,
                            noDataWidget: const MyNoData(),
                            builderWidget: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                bottom: SizeUtils.scaleMobile(20, size.width),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: SizeUtils.scaleMobile(10, size.width),
                              ),
                              itemCount:
                                  controller.staffAttendanceList.value.length,
                              itemBuilder: (context, index) {
                                final attendance =
                                    controller.staffAttendanceList.value[index];
                                final staff = controller.staffs.firstWhere(
                                    (element) =>
                                        element.id == attendance.userId,
                                    orElse: () => UserModel());
                                final position = controller.positionList
                                    .firstWhere(
                                        (element) =>
                                            element.id == staff.positionId,
                                        orElse: () => PositionModel());
                                return StaffAttendanceCard(
                                  staff: staff,
                                  attendance: attendance,
                                  position: position,
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
              const HomeStaffMobileView(),
            ],
          ),
        ),
      ],
    );
  }
}
