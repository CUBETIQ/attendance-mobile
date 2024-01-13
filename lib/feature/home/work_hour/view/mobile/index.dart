import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/card/my_card.dart';
import 'package:attendance_app/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/home/work_hour/controller/index.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WorkingHourViewMobile extends StatelessWidget {
  const WorkingHourViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = WorkHourController.to;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Working Hour",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
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
              top: SizeUtils.scale(AppSize.paddingVerticalLarge, size.width),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(text: "Work Overview", style: BodyXlargeMedium),
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.staffs.length,
                  itemBuilder: (context, index) {
                    final staff = controller.staffs[index];
                    final attendance = controller.attendances.firstWhere(
                      (element) => element.userId == staff.id,
                      orElse: () => AttendanceModel(),
                    );
                    final position = controller.positions.firstWhere(
                      (element) => element.id == staff.positionId,
                      orElse: () => PositionModel(),
                    );
                    int? totalWorkMinute;
                    double? percentage;
                    if (attendance.checkInDateTime != null) {
                      totalWorkMinute =
                          DateFormatter().calculateDurationInMinutes(
                        attendance.checkInDateTime ?? 0,
                        attendance.checkOutDateTime,
                      );
                      percentage = totalWorkMinute /
                          NavigationController.to.totalWorkMinutes.value;
                    }
                    return MyCard(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.scale(
                          AppSize.paddingHorizontalLarge,
                          size.width,
                        ),
                        vertical: SizeUtils.scale(
                          AppSize.paddingVerticalMedium,
                          size.width,
                        ),
                      ),
                      margin: EdgeInsets.only(
                        bottom: SizeUtils.scale(
                          10,
                          size.width,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              MyCacheImage(
                                imageUrl: staff.image,
                                width: SizeUtils.scale(40, size.width),
                                height: SizeUtils.scale(40, size.width),
                              ),
                              SizedBox(width: SizeUtils.scale(15, size.width)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          SizeUtils.scale(210, size.width),
                                    ),
                                    child: MyText(
                                      text: staff.firstName != null &&
                                                  staff.firstName != "" ||
                                              staff.lastName != null &&
                                                  staff.lastName != ""
                                          ? "${staff.firstName} ${staff.lastName}"
                                          : staff.username ?? "N/A",
                                      style: BodyMediumMedium,
                                    ),
                                  ),
                                  MyText(
                                    text: position.name ?? "N/A",
                                    style: BodyMediumMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: SizeUtils.scale(10, size.width)),
                          LinearPercentIndicator(
                            animation: true,
                            lineHeight: SizeUtils.scale(
                              12,
                              size.width,
                            ),
                            animationDuration: 2000,
                            padding: EdgeInsets.zero,
                            percent: percentage ?? 0,
                            barRadius: Radius.circular(
                              SizeUtils.scale(
                                AppSize.borderRadiusLarge,
                                size.width,
                              ),
                            ),
                            progressColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(height: SizeUtils.scale(10, size.width)),
                          Row(
                            children: [
                              const MyText(text: "Total Hour: "),
                              SizedBox(width: SizeUtils.scale(10, size.width)),
                              MyText(
                                  text:
                                      '${DateFormatter().formatMinutes(totalWorkMinute ?? 0)}/8:00')
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
