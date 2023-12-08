import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/widgets/async_widget/async_base_widget.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/home/controller/index.dart';
import 'package:attendance_app/feature/home/widget/attendance_card.dart';
import 'package:attendance_app/feature/home/widget/overview_card.dart';
import 'package:attendance_app/feature/home/widget/record_card.dart';
import 'package:attendance_app/feature/home/widget/statuc_dot.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeStaffMobileView extends StatelessWidget {
  const HomeStaffMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.to;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
                            status: NavigationController.to.user.value.status,
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
                      MyText(
                        text: NavigationController.to.user.value.username ??
                            "-----",
                        style: BodyXlargeMedium,
                      ),
                      MyText(
                        text: NavigationController.to.position.value.name ??
                            "-----",
                        style: BodyMediumRegular,
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
                vertical: size.height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        clockBack,
                        width: size.height * 0.03,
                        height: size.height * 0.03,
                      ),
                      Obx(
                        () => MyText(
                          text: controller.checkInTime.value ?? "--:--",
                          style: BodyMediumRegular,
                        ),
                      ),
                      MyText(
                        text: "Check In",
                        style: BodyMediumRegular,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        clockForward,
                        width: size.height * 0.025,
                        height: size.height * 0.025,
                      ),
                      Obx(
                        () => MyText(
                          text: controller.checkOutTime.value ?? "--:--",
                          style: BodyMediumRegular,
                        ),
                      ),
                      MyText(
                        text: "Check In",
                        style: BodyMediumRegular,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        clock,
                        width: size.height * 0.03,
                        height: size.height * 0.03,
                      ),
                      Obx(
                        () => MyText(
                          text: controller.totalHour.value != null &&
                                  controller.totalHour.value != "null"
                              ? controller.totalHour.value ?? "--:--"
                              : "--:--",
                          style: BodyMediumRegular,
                        ),
                      ),
                      MyText(
                        text: "Working Hour",
                        style: BodyMediumRegular,
                      ),
                    ],
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
                const Expanded(
                    child: OverviewCard(
                  image: present,
                  title: "Attendance",
                  number: "65",
                )),
                SizedBox(width: size.width * 0.02),
                const Expanded(
                    child: OverviewCard(
                  image: absent,
                  title: "Absent",
                  number: "1",
                )),
                SizedBox(width: size.width * 0.02),
                const Expanded(
                    child: OverviewCard(
                  image: onLeave,
                  number: "2",
                  title: "On Leave",
                )),
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
                builderWidget: ListView.separated(
                  itemCount: controller.attendanceList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return RecordCard();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
