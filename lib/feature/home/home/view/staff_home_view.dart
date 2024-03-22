import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/home/home/controller/index.dart';
import 'package:timesync/feature/home/home/widget/attendance_card.dart';
import 'package:timesync/feature/home/home/widget/overview_card.dart';
import 'package:timesync/feature/home/home/widget/record_card.dart';
import 'package:timesync/feature/home/home/widget/status_dot.dart';
import 'package:timesync/feature/home/home/widget/total_hour_worked_card.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

class HomeStaffView extends StatelessWidget {
  const HomeStaffView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.to;
    final size = MediaQuery.of(context).size;
    return MyRefreshIndicator(
      onRefresh: () async {
        controller.onRefresh();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeUtils.scale(20, size.width)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: SizeUtils.scale(11, size.width),
                    bottom: SizeUtils.scale(20, size.width)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeUtils.scale(15, size.width)),
                      child: Stack(
                        children: [
                          Obx(
                            () => MyCacheImage(
                              imageUrl:
                                  NavigationController.to.user.value.image ??
                                      "",
                              width: SizeUtils.scale(40, size.width),
                              height: SizeUtils.scale(40, size.width),
                            ),
                          ),
                          Positioned(
                            bottom: SizeUtils.scale(0, size.width),
                            right: SizeUtils.scale(2, size.width),
                            child: PopupMenuButton<String>(
                              onSelected: controller.onSelectStatus,
                              splashRadius: null,
                              offset: Offset.zero,
                              padding: EdgeInsets.zero,
                              itemBuilder: (BuildContext context) {
                                return controller.status.value.map((status) {
                                  return PopupMenuItem<String>(
                                    value: status,
                                    child: Text(
                                      status.capitalizeAllWordsFirstLetter(),
                                    ),
                                  );
                                }).toList();
                              },
                              child: Obx(
                                () => StatusDot(
                                  status: controller.selectedStatus.value,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: SizeUtils.scale(4, size.width)),
                            child: Obx(
                              () => MyText(
                                text: StringUtil.getfullname(
                                  controller.user.value.firstName,
                                  controller.user.value.lastName,
                                  controller.user.value.username,
                                ),
                                style: AppFonts.TitleMedium,
                              ),
                            ),
                          ),
                          Obx(
                            () => MyText(
                              text:
                                  NavigationController.to.position.value.name ??
                                      "-----",
                              style: AppFonts.LabelSmall,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: SizeUtils.scale(12, size.width)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: "Overview",
                      style: AppFonts.TitleMedium,
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
              Obx(
                () => OverviewCard(
                  presence: controller.totalAttendance.value,
                  absence: controller.totalAbsent.value,
                  leave: controller.totalLeave.value,
                  lateness: '0 hr',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.scale(20, size.width)),
                child: Obx(
                  () => AttendanceCard(
                    isInOfficeRange: NavigationController.to.isInRange.value,
                    scale: controller.scaleAnimation,
                    onCheckIn: controller.checkIn,
                    onCheckOut: controller.checkOut,
                    currentDate: controller.currentDate.value,
                    isCheckedIn: controller.isCheckedIn.value,
                    isStartBreakTime: controller.isStartBreakTime.value,
                    isEndBreakTime: controller.isEndBreakTime.value,
                    onTapBreakTime: controller.onTapBreak,
                  ),
                ),
              ),
              MyText(
                text: "Today Record",
                style: AppFonts.TitleMedium,
              ),
              Padding(
                padding: EdgeInsets.only(top: SizeUtils.scale(12, size.width)),
                child: Obx(
                  () => MyAsyncWidget(
                    isLoading: controller.isLoadingList.value,
                    list: controller.attendanceList,
                    noDataWidget: RecordCard(
                      date: controller.date,
                      data: null,
                      isBreakTime: false,
                    ),
                    builderWidget: ListView.separated(
                      itemCount: controller.attendanceList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                        height: SizeUtils.scale(10, size.width),
                      ),
                      itemBuilder: (context, index) {
                        return Obx(
                          () => RecordCard(
                            date: controller.date,
                            data: controller.attendanceList[index],
                            isBreakTime: controller
                                    .attendanceList[index].breakTime?.start !=
                                null,
                            endBreakTime:
                                controller.attendanceList[index].breakTime?.end,
                            startBreakTime: controller
                                .attendanceList[index].breakTime?.start,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.scale(20, size.width)),
                child: Obx(
                  () => TotalHourWorkedCard(
                    totalHourWorked: StringUtil().calculateDuration(
                      controller.totalWorkHour.value,
                    ),
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
