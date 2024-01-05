import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/extensions/string.dart';
import 'package:attendance_app/feature/home/home/controller/index.dart';
import 'package:attendance_app/feature/home/home/view/mobile/staff_home_view.dart';
import 'package:attendance_app/feature/home/home/widget/pie_chart_card.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_formater.dart';
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
        Container(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: TabBar(
            controller: controller.tabController,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            labelStyle: BodyLargeMedium,
            unselectedLabelStyle: BodyLargeMedium,
            unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
            labelColor: Theme.of(context).colorScheme.onBackground,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(
                text: 'Dashboard'.trString,
              ),
              Tab(
                text: 'Attendance'.trString,
              ),
            ],
          ),
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
                          GestureDetector(
                            onTap: controller.onTapDate,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeUtils.scale(
                                  AppSize.paddingS5,
                                  size.width,
                                ),
                                vertical: SizeUtils.scale(
                                  AppSize.paddingS2,
                                  size.width,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  SizeUtils.scale(
                                    AppSize.borderRadiusLarge,
                                    size.width,
                                  ),
                                ),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Row(
                                children: [
                                  Obx(
                                    () => MyText(
                                      text: DateFormatter().formatShortDate(
                                        controller.selectDate.value,
                                      ),
                                      style: BodySmall.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeUtils.scale(
                                      AppSize.paddingS1,
                                      size.width,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ],
                              ),
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
                            child: Container(
                              height: SizeUtils.scale(150, size.width),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  SizeUtils.scale(
                                    AppSize.borderRadiusLarge,
                                    size.width,
                                  ),
                                ),
                                color: Theme.of(context).colorScheme.background,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.15),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Badge(
                                    label: const MyText(
                                      text: '10',
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          SizeUtils.scale(10, size.width)),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      child: Icon(
                                        Icons.edit_document,
                                        size: SizeUtils.scale(40, size.width),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeUtils.scale(10, size.width),
                                  ),
                                  MyText(
                                    text: 'Leave Request',
                                    style: BodyLargeMedium,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: SizeUtils.scale(20, size.width)),
                          Expanded(
                            child: Container(
                              height: SizeUtils.scale(150, size.width),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  SizeUtils.scale(
                                    AppSize.borderRadiusLarge,
                                    size.width,
                                  ),
                                ),
                                color: Theme.of(context).colorScheme.background,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.15),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                        SizeUtils.scale(10, size.width)),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Icon(
                                      Icons.task,
                                      size: SizeUtils.scale(40, size.width),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeUtils.scale(10, size.width),
                                  ),
                                  MyText(
                                    text: 'Task',
                                    style: BodyLargeMedium,
                                  )
                                ],
                              ),
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
