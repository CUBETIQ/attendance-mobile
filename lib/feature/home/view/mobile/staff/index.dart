import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/home/controller/index.dart';
import 'package:attendance_app/feature/home/widget/attendance_card.dart';
import 'package:attendance_app/feature/home/widget/overview_card.dart';
import 'package:attendance_app/feature/home/widget/record_card.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/utils/time_formater.dart';
import 'package:flutter/material.dart';
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
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text:
                            "Hey ${NavigationController.to.user.value.username}",
                        style: BodyXlargeMedium,
                      ),
                      SizedBox(height: size.height * 0.007),
                      MyText(
                        text: DateFormatter().formatDate(
                          controller.date,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                        image: NetworkImage(
                          NavigationController.to.user.value.image!,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Row(
              children: [
                Obx(
                  () => AttendanceCard(
                    title: "Check In",
                    time: controller.checkInTime.value,
                    buttonText: "Check In",
                    image: checkIn,
                    isCheckedIn: controller.isCheckedIn.value,
                    onPressed: controller.checkIn,
                  ),
                ),
                const Spacer(),
                Obx(
                  () => AttendanceCard(
                    title: "Check Out",
                    time: controller.checkOutTime.value,
                    buttonText: "Check Out",
                    image: checkOut,
                    buttonDisable: controller.disableCheckOut.value,
                    onPressed: controller.checkOut,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            MyText(
              text: "Overview",
              style: BodyXlarge,
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
            ListView.separated(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: 15),
              itemBuilder: (context, index) {
                return RecordCard();
              },
            )
          ],
        ),
      ),
    );
  }
}
