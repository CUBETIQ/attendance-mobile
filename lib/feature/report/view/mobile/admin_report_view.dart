import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync360/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:timesync360/core/widgets/no_data/no_data.dart';
import 'package:timesync360/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/home/home/widget/tab_bar.dart';
import 'package:timesync360/feature/report/controller/index.dart';
import 'package:timesync360/feature/report/view/mobile/staff_report_view.dart';
import 'package:timesync360/feature/report/widget/employee_attendance_report_card.dart';
import 'package:timesync360/feature/report/widget/employee_leave_report_card.dart';
import 'package:timesync360/feature/report/widget/employee_task_report_card.dart';
import 'package:timesync360/feature/report/widget/toggle_button.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AdminReportViewMobile extends StatelessWidget {
  const AdminReportViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ReportController.to;
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
                onRefresh: controller.onRefresh,
                child: SizedBox(
                  height: size.height,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: SizeUtils.scale(
                          AppSize().paddingHorizontalLarge,
                          size.width,
                        ),
                        right: SizeUtils.scale(
                          AppSize().paddingHorizontalLarge,
                          size.width,
                        ),
                        top: SizeUtils.scale(
                            AppSize().paddingVerticalLarge, size.width),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: 'Report Overview',
                                style: AppStyles().bodyLargeMedium.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                              ),
                              Obx(
                                () => DateDropDown(
                                  date: controller.selectedDate.value,
                                  size: size,
                                  onTap: controller.onTapDate,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeUtils.scale(20, size.width)),
                          Obx(
                            () => ToggleButton(
                              currentIndex: controller.selectTabIndex.value,
                              onChanged: controller.onTabChange,
                              selectedIndex: controller.selectTabIndex.value,
                              icons: controller.reportTabIcon,
                              values: const [0, 1, 2],
                            ),
                          ),
                          SizedBox(height: SizeUtils.scale(20, size.width)),
                          Obx(
                            () => MyAsyncWidget(
                              isLoading: controller.isLoading.value,
                              list: controller.staffReports.value,
                              noDataWidget: const MyNoData(),
                              builderWidget: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => SizedBox(
                                    height: SizeUtils.scale(10, size.width)),
                                itemCount: controller.selectTabIndex.value == 2
                                    ? controller.staffReports.value.length
                                    : controller.selectTabIndex.value == 1
                                        ? controller
                                            .staffTaskReports.value.length
                                        : controller
                                            .staffLeaveReports.value.length,
                                itemBuilder:
                                    controller.selectTabIndex.value == 2
                                        ? (context, index) {
                                            final staff = controller
                                                .staffReports.value[index];
                                            int totalWorkMinute =
                                                staff.attendance?.duration ?? 0;
                                            return EmployeeAttendanceReportCard(
                                              data: staff,
                                              totalWorkMinute: totalWorkMinute,
                                            );
                                          }
                                        : controller.selectTabIndex.value == 1
                                            ? (context, index) {
                                                return EmployeeTaskReportCard(
                                                  data: controller
                                                      .staffTaskReports
                                                      .value[index],
                                                );
                                              }
                                            : (context, index) {
                                                return EmployeeLeaveReportCard(
                                                  data: controller
                                                      .staffLeaveReports
                                                      .value[index],
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
              const StaffReportViewMobile(),
            ],
          ),
        ),
      ],
    );
  }
}
