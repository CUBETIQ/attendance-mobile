import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync360/core/widgets/card/my_card.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/home/home/controller/index.dart';
import 'package:timesync360/feature/home/home/widget/attendance_card.dart';
import 'package:timesync360/feature/home/home/widget/attendance_detail_card.dart';
import 'package:timesync360/feature/home/home/widget/overview_card.dart';
import 'package:timesync360/feature/home/home/widget/record_card.dart';
import 'package:timesync360/feature/home/home/widget/status_dot.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/string_util.dart';
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
            top: AppSize().paddingTitleSmall,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeUtils.scale(55, size.width),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Obx(
                          () => MyCacheImage(
                            imageUrl:
                                NavigationController.to.user.value.image ?? "",
                            width: SizeUtils.scale(55, size.width),
                            height: SizeUtils.scale(55, size.width),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 2,
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
                    SizedBox(width: AppSize().paddingS5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Container(
                            constraints: BoxConstraints(
                              maxWidth: SizeUtils.scale(240, size.width),
                            ),
                            child: MyText(
                              text: StringUtil().getfullname(
                                controller.user.value.firstName,
                                controller.user.value.lastName,
                                controller.user.value.username,
                              ),
                              style: AppStyles().bodyXlargeMedium,
                            ),
                          ),
                        ),
                        Obx(
                          () => MyText(
                            text: NavigationController.to.position.value.name ??
                                "-----",
                            style: AppStyles().bodyMediumRegular,
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
                style: AppStyles().bodyXlargeMedium,
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
              MyCard(
                width: double.infinity,
                height: size.height * 0.12,
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.018,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(
                      () => AttendanceDetailCard(
                        image: SvgAssets.clockBack,
                        time: controller.checkInTime.value ?? "--:--",
                        title: "Check In",
                      ),
                    ),
                    Obx(
                      () => AttendanceDetailCard(
                        image: SvgAssets.clockForward,
                        time: controller.checkOutTime.value ?? "--:--",
                        title: "Check Out",
                      ),
                    ),
                    Obx(
                      () => AttendanceDetailCard(
                        image: SvgAssets.clock,
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
                style: AppStyles().bodyXlargeMedium,
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => OverviewCard(
                        image: SvgAssets.present,
                        title: "Present",
                        number: controller.totalAttendance.value.toString(),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: Obx(
                      () => OverviewCard(
                        image: SvgAssets.absent,
                        title: "Absent",
                        number: controller.totalAbsent.value.toString(),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: Obx(
                      () => OverviewCard(
                        image: SvgAssets.onLeave,
                        number: controller.totalLeave.value.toString(),
                        title: "On Leave",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              MyText(
                text: "Today Record",
                style: AppStyles().bodyXlarge,
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
                        const SizedBox.shrink(),
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
