import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/extensions/string.dart';
import 'package:attendance_app/feature/home/controller/index.dart';
import 'package:attendance_app/feature/home/view/mobile/staff_home_view.dart';
import 'package:attendance_app/feature/home/widget/attendance_detail_card.dart';
import 'package:attendance_app/feature/leave/leave/widget/leave_chart.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeAdminMobileView extends StatelessWidget {
  const HomeAdminMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.to;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primaryContainer,
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
                      Container(
                        width: size.width,
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: Colors.green,
                                value: 40,
                                title: "Present",
                                radius: 100,
                                titleStyle: BodyMediumRegular.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                color: Colors.red,
                                value: 30,
                                title: "Absent",
                                radius: 100,
                                titleStyle: BodyMediumRegular.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                color: Colors.yellow,
                                value: 30,
                                title: "Leave",
                                radius: 100,
                                titleStyle: BodyMediumRegular.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          swapAnimationDuration:
                              const Duration(milliseconds: 150),
                          swapAnimationCurve: Curves.linear,
                        ),
                      ),
                      MyText(
                          text: "Attendance Summary", style: BodyLargeMedium),
                      const SizedBox(height: AppSize.paddingS10),
                      Row(
                        children: [
                          const Expanded(
                            child: LeaveChart(
                              title: "Present",
                              radius: 35,
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          const Expanded(
                            child: LeaveChart(
                              title: "Absent",
                              radius: 35,
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          const Expanded(
                            child: LeaveChart(
                              title: "Leave",
                              radius: 35,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.paddingS14),
                      MyText(text: "Check In Overview", style: BodyLargeMedium),
                      const SizedBox(height: AppSize.paddingS10),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: MyText(
                              text: "Early",
                              style: BodyMediumRegular,
                            ),
                          ),
                          Expanded(
                            child: LinearPercentIndicator(
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: 0.7,
                              center: const Text("70.0%"),
                              barRadius: Radius.circular(
                                SizeUtils.scale(20, size.width),
                              ),
                              progressColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.paddingS2),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child:
                                MyText(text: "Good", style: BodyMediumRegular),
                          ),
                          Expanded(
                            child: LinearPercentIndicator(
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: 0.2,
                              center: const Text("20.0%"),
                              barRadius: Radius.circular(
                                SizeUtils.scale(20, size.width),
                              ),
                              progressColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.paddingS2),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: MyText(
                              text: "Late",
                              style: BodyMediumRegular,
                            ),
                          ),
                          Expanded(
                            child: LinearPercentIndicator(
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: 0.1,
                              center: const Text("10.0%"),
                              barRadius: Radius.circular(
                                SizeUtils.scale(20, size.width),
                              ),
                              progressColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.paddingS14),
                      MyText(
                          text: "Check Out Overview", style: BodyLargeMedium),
                      const SizedBox(height: AppSize.paddingS10),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: MyText(
                              text: "Early",
                              style: BodyMediumRegular,
                            ),
                          ),
                          Expanded(
                            child: LinearPercentIndicator(
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: 0.7,
                              center: const Text("70.0%"),
                              barRadius: Radius.circular(
                                SizeUtils.scale(20, size.width),
                              ),
                              progressColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.paddingS2),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child:
                                MyText(text: "Good", style: BodyMediumRegular),
                          ),
                          Expanded(
                            child: LinearPercentIndicator(
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: 0.2,
                              center: const Text("20.0%"),
                              barRadius: Radius.circular(
                                SizeUtils.scale(20, size.width),
                              ),
                              progressColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.paddingS2),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: MyText(
                              text: "Late",
                              style: BodyMediumRegular,
                            ),
                          ),
                          Expanded(
                            child: LinearPercentIndicator(
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: 0.1,
                              center: const Text("10.0%"),
                              barRadius: Radius.circular(
                                SizeUtils.scale(20, size.width),
                              ),
                              progressColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.paddingS14),
                      MyText(text: "Staff Overview", style: BodyLargeMedium),
                      const SizedBox(height: AppSize.paddingS10),
                      ListView.separated(
                          itemCount: 10,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: AppSize.paddingS10),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "Staff Name",
                                  style: BodyMediumRegular,
                                ),
                                const SizedBox(height: AppSize.paddingS4),
                                Container(
                                  width: double.infinity,
                                  height: size.height * 0.12,
                                  padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.018,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      AppSize.borderRadiusLarge *
                                          (size.width / 375.0),
                                    ),
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.17),
                                        spreadRadius: 1.2,
                                        blurRadius: 1.2,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Obx(
                                        () => AttendanceDetailCard(
                                          image: clockBack,
                                          time: controller.checkInTime.value ??
                                              "--:--",
                                          title: "Check In",
                                        ),
                                      ),
                                      Obx(
                                        () => AttendanceDetailCard(
                                          image: clockForward,
                                          time: controller.checkOutTime.value ??
                                              "--:--",
                                          title: "Check Out",
                                        ),
                                      ),
                                      Obx(
                                        () => AttendanceDetailCard(
                                          image: clock,
                                          time: controller.totalHour.value ??
                                              "--:--",
                                          title: "Total Hour",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
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
