import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/extensions/string.dart';
import 'package:attendance_app/feature/home/home/controller/index.dart';
import 'package:attendance_app/feature/home/home/view/mobile/staff_home_view.dart';
import 'package:attendance_app/feature/home/home/widget/button_card.dart';
import 'package:attendance_app/feature/home/home/widget/date_dropdown.dart';
import 'package:attendance_app/feature/home/home/widget/pie_chart_card.dart';
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
                          const Expanded(
                            child: ButtonCard(
                              icon: Icons.edit_document,
                              title: "Leave",
                            ),
                          ),
                          SizedBox(width: SizeUtils.scale(20, size.width)),
                          const Expanded(
                            child: ButtonCard(
                              icon: Icons.task,
                              title: "Task",
                            ),
                          ),
                        ],
                      )
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
