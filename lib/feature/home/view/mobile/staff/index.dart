import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/widgets/async_widget/async_base_widget.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/home/controller/index.dart';
import 'package:attendance_app/feature/home/widget/attendance_card.dart';
import 'package:attendance_app/feature/home/widget/attendance_detail_card.dart';
import 'package:attendance_app/feature/home/widget/overview_card.dart';
import 'package:attendance_app/feature/home/widget/record_card.dart';
import 'package:attendance_app/feature/home/widget/status_dot.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeStaffMobileView extends StatelessWidget {
  const HomeStaffMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.to;
    final size = MediaQuery.of(context).size;
    return MyRefreshIndicator(
      onRefresh: () async {
        controller.onRefresh();
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSize.paddingHorizontalLarge,
            right: AppSize.paddingHorizontalLarge,
            top: AppSize.paddingTitleSmall,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 55,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        MyCacheImage(
                          imageUrl:
                              NavigationController.to.user.value.image ?? "",
                          width: 55,
                          height: 55,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 2,
                          child: Obx(
                            () => StatusDot(
                              status: controller.user.value.status,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: AppSize.paddingS5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => MyText(
                            text: controller.name.value ?? "-----",
                            style: BodyXlargeMedium,
                          ),
                        ),
                        Obx(
                          () => MyText(
                            text: NavigationController.to.position.value.name ??
                                "-----",
                            style: BodyMediumRegular,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              MyText(
                text: "Attendance ",
                style: BodyXlargeMedium,
              ),
              SizedBox(height: size.height * 0.015),
              Obx(
                () => AttendanceCard(
                  scale: controller.scaleAnimation,
                  onCheckIn: controller.checkIn,
                  onCheckOut: controller.checkOut,
                  currentDate: controller.currentDate.value,
                  isCheckedIn: controller.isCheckedIn.value,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                width: double.infinity,
                height: size.height * 0.12,
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.018,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppSize.borderRadiusLarge * (size.width / 375.0),
                  ),
                  color: Theme.of(context).colorScheme.surface,
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(
                      () => AttendanceDetailCard(
                        image: clockBack,
                        time: controller.checkInTime.value ?? "--:--",
                        title: "Check In",
                      ),
                    ),
                    Obx(
                      () => AttendanceDetailCard(
                        image: clockForward,
                        time: controller.checkOutTime.value ?? "--:--",
                        title: "Check Out",
                      ),
                    ),
                    Obx(
                      () => AttendanceDetailCard(
                        image: clock,
                        time: controller.totalHour.value ?? "--:--",
                        title: "Total Hour",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              MyText(
                text: "Overview",
                style: BodyXlargeMedium,
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => OverviewCard(
                        image: present,
                        title: "Attendance",
                        number: controller
                            .summaryAttendance.value?.totalAttendance
                            .toString(),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: Obx(
                      () => OverviewCard(
                        image: absent,
                        title: "Absent",
                        number: controller.summaryAttendance.value?.totalAbsent
                            .toString(),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: Obx(
                      () => OverviewCard(
                        image: onLeave,
                        number: controller.summaryAttendance.value?.totalLeave
                            .toString(),
                        title: "On Leave",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              MyText(
                text: "Today Record",
                style: BodyXlarge,
              ),
              SizedBox(height: size.height * 0.02),
              Obx(
                () => MyAsyncWidget(
                  isLoading: controller.isLoadingList.value,
                  list: controller.attendanceList,
                  noDataWidget: RecordCard(
                    date: controller.date,
                    checkInStatus: null,
                    checkInTime: null,
                    checkOutTime: null,
                    checkOutStatus: null,
                    isBreakTime: false,
                  ),
                  builderWidget: ListView.separated(
                    itemCount: controller.attendanceList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return Obx(
                        () => RecordCard(
                          date: controller.date,
                          checkInStatus:
                              controller.attendanceList[index].checkInStatus,
                          checkInTime:
                              controller.attendanceList[index].checkInDateTime,
                          checkOutTime:
                              controller.attendanceList[index].checkOutDateTime,
                          checkOutStatus:
                              controller.attendanceList[index].checkOutStatus,
                          isBreakTime: controller.isBreakTime.value,
                          breakTimeTitle: controller.breakTimeTitle.value,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
