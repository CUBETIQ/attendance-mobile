import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync/core/widgets/no_data/no_data.dart';
import 'package:timesync/core/widgets/pie_chart/pie_chart.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/feature/home/home/controller/index.dart';
import 'package:timesync/feature/home/home/view/staff_home_view.dart';
import 'package:timesync/feature/home/home/widget/button_card.dart';
import 'package:timesync/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:timesync/feature/home/home/widget/linear_indicator.dart';
import 'package:timesync/feature/home/home/widget/staff_attendance_card.dart';
import 'package:timesync/feature/home/home/widget/tab_bar.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/attendance_status.dart';
import 'package:timesync/utils/logger.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAdminView extends StatelessWidget {
  const HomeAdminView({super.key});

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
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.scale(20, size.width),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeUtils.scale(15, size.width)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: 'Overall Attendance',
                                style: AppFonts.TitleSmall.copyWith(
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
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeUtils.scale(20, size.width)),
                          child: Obx(
                            () => MyPieChart(
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
                              firstPercentage:
                                  controller.presentPercentage.value,
                              secondPercentage:
                                  controller.onLeavePercentage.value,
                              thirdPercentage:
                                  controller.absentPercentage.value,
                              haveNoData: controller.haveNoData.value,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: SizeUtils.scale(16, size.width)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonCard(
                                svgIcon: IconAssets.document,
                                title: "Leave",
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                onTap: () => Get.toNamed(
                                  Routes.ADMIN_LEAVE_REQUEST,
                                  arguments: controller.staffs.value,
                                ),
                              ),
                              SizedBox(width: SizeUtils.scale(16, size.width)),
                              ButtonCard(
                                svgIcon: IconAssets.timeCircle,
                                title: "Work Hour",
                                color: Theme.of(context).colorScheme.secondary,
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: SizeUtils.scale(14, size.width)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: MyText(
                                  text: 'Attendance Statistic',
                                  style: AppFonts.TitleSmall.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ),
                              Obx(
                                () => MyDropDownButton<String>(
                                  width: SizeUtils.scale(130, size.width),
                                  borderColor:
                                      Theme.of(context).colorScheme.primary,
                                  buttonPadding: EdgeInsets.only(
                                    left: SizeUtils.scale(0, size.width),
                                    right: SizeUtils.scale(10, size.width),
                                    top: SizeUtils.scale(1, size.width),
                                    bottom: SizeUtils.scale(1, size.width),
                                  ),
                                  dropdownPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeUtils.scale(10, size.width)),
                                  borderRadius: SizeUtils.scale(24, size.width),
                                  label: "Type",
                                  hasLabel: false,
                                  value:
                                      controller.selectedAttendanceType.value,
                                  hint: "Choose Type",
                                  dropdownItems: controller.attendanceType
                                      .map(
                                        (e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: MyText(
                                            text: e.trString,
                                            style:
                                                AppFonts.TitleXSmall.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: controller.onChanged,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Obx(
                              () => LinearIndicator(
                                onTap: () =>
                                    controller.onTapAttendanceStatistic(
                                  AttendanceStatus.early,
                                ),
                                title: "Early",
                                color: Theme.of(context).colorScheme.tertiary,
                                percent: controller.earlyPercentage.value,
                                totalEmployees: controller.totalStaff.value,
                                checkInEmployees:
                                    controller.totalCheckInEarly.value,
                                checkOutEmployees:
                                    controller.totalCheckOutEarly.value,
                                isCheckIn: controller.isCheckIn.value,
                              ),
                            ),
                            Obx(
                              () => LinearIndicator(
                                onTap: () =>
                                    controller.onTapAttendanceStatistic(
                                  AttendanceStatus.onTime,
                                ),
                                title: "On Time",
                                color: Theme.of(context).colorScheme.secondary,
                                percent: controller.onTimePercentage.value,
                                totalEmployees: controller.totalStaff.value,
                                checkInEmployees:
                                    controller.totalCheckInOnTime.value,
                                checkOutEmployees:
                                    controller.totalCheckOutOnTime.value,
                                isCheckIn: controller.isCheckIn.value,
                              ),
                            ),
                            Obx(
                              () => LinearIndicator(
                                onTap: () =>
                                    controller.onTapAttendanceStatistic(
                                  AttendanceStatus.late,
                                ),
                                title: "Late",
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                percent: controller.latePercentage.value,
                                totalEmployees: controller.totalStaff.value,
                                checkInEmployees:
                                    controller.totalCheckInLate.value,
                                checkOutEmployees:
                                    controller.totalCheckOutLate.value,
                                isCheckIn: controller.isCheckIn.value,
                              ),
                            ),
                          ].withSpaceBetween(
                              height: SizeUtils.scale(14, size.width)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeUtils.scale(16, size.width),
                              bottom: SizeUtils.scale(14, size.width)),
                          child: MyText(
                            text: 'Attendance Log'.trString,
                            style: AppFonts.TitleSmall.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                        Obx(
                          () => MyAsyncWidget(
                            isLoading: controller.isLoadingList.value,
                            list: controller.staffAttendanceList,
                            noDataWidget: const MyNoData(),
                            builderWidget: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                bottom: SizeUtils.scale(14, size.width),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: SizeUtils.scale(10, size.width),
                              ),
                              itemCount:
                                  controller.staffAttendanceList.value.length,
                              itemBuilder: (context, index) {
                                final staff =
                                    controller.filterStaffs.value[index];
                                final attendance = controller
                                    .backUpStaffAttendanceList
                                    .where(
                                        (element) => element.userId == staff.id)
                                    .toList();
                                final position = controller.positionList
                                    .firstWhere(
                                        (element) =>
                                            element.id == staff.positionId,
                                        orElse: () => PositionModel());
                                Logs.i("staff: $staff");
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
              const HomeStaffView(),
            ],
          ),
        ),
      ],
    );
  }
}
