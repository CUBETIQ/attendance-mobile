import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/async_widget/async_base_widget.dart';
import 'package:attendance_app/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:attendance_app/core/widgets/no_data/no_data.dart';
import 'package:attendance_app/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/home/home/widget/tab_bar.dart';
import 'package:attendance_app/feature/report/controller/index.dart';
import 'package:attendance_app/feature/report/view/mobile/staff_report_view.dart';
import 'package:attendance_app/feature/report/widget/attendance_report_card.dart';
import 'package:attendance_app/utils/size_util.dart';
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
                          AppSize.paddingHorizontalLarge,
                          size.width,
                        ),
                        right: SizeUtils.scale(
                          AppSize.paddingHorizontalLarge,
                          size.width,
                        ),
                        top: SizeUtils.scale(
                            AppSize.paddingVerticalLarge, size.width),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: 'Report Overview',
                                style: BodyLargeMedium.copyWith(
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
                            () => MyAsyncWidget(
                              isLoading: controller.isLoading.value,
                              list: controller.staffReports.value,
                              noDataWidget: const MyNoData(),
                              builderWidget: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => SizedBox(
                                    height: SizeUtils.scale(10, size.width)),
                                itemCount: controller.staffReports.value.length,
                                itemBuilder: (context, index) {
                                  final staff =
                                      controller.staffReports.value[index];
                                  int totalWorkMinute =
                                      staff.attendance?.duration ?? 0;
                                  return AttendanceReportCard(
                                    data: staff,
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
              const StaffReportViewMobile(),
            ],
          ),
        ),
      ],
    );
  }
}
