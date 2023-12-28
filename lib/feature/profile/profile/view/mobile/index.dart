import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/profile/profile/controller/index.dart';
import 'package:attendance_app/feature/profile/profile/widget/attendance_profile_card.dart';
import 'package:attendance_app/feature/profile/profile/widget/job_company_title.dart';
import 'package:attendance_app/feature/profile/profile/widget/kpi_score_card.dart';
import 'package:attendance_app/feature/profile/profile/widget/option_button.dart';
import 'package:attendance_app/feature/profile/profile/widget/profile_detail_row.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_formater.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileViewMobile extends StatelessWidget {
  const ProfileViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProfileController.to;
    final size = MediaQuery.of(context).size;
    return MyRefreshIndicator(
      onRefresh: () async {
        controller.onRefresh();
      },
      child: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeUtils.scaleWidth(
                  AppSize.paddingHorizontalLarge, size.width),
              right: SizeUtils.scaleWidth(
                  AppSize.paddingHorizontalLarge, size.width),
              top: SizeUtils.scaleWidth(AppSize.paddingTitleSmall, size.width),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: size.width * 0.85,
                    ),
                    Positioned(
                      top: SizeUtils.scaleWidth(65, size.width),
                      child: Container(
                        height: size.width * 0.66,
                        width:
                            size.width - SizeUtils.scaleWidth(48, size.width),
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeUtils.scaleWidth(
                            AppSize.paddingHorizontalLarge,
                            size.width,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            SizeUtils.scaleWidth(
                              AppSize.borderRadiusLarge,
                              size.width,
                            ),
                          ),
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withOpacity(0.15),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: SizeUtils.scaleWidth(
                                size.width * 0.105,
                                size.width,
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: size.width * 0.7,
                              ),
                              child: Obx(
                                () => MyText(
                                  text: controller.name.value ?? "--------",
                                  style: BodyXlargeMedium,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Obx(
                              () => JobCompanyTitle(
                                organization: NavigationController
                                        .to.organization.value.name ??
                                    "Comapny",
                                position: NavigationController
                                        .to.position.value.name ??
                                    "Position",
                              ),
                            ),
                            SizedBox(height: size.height * 0.015),
                            Obx(
                              () => ProfileDetailRow(
                                title: "Department",
                                value: NavigationController
                                    .to.department.value.name,
                              ),
                            ),
                            Obx(
                              () => ProfileDetailRow(
                                title: "Gender",
                                value: controller.user.value.gender,
                              ),
                            ),
                            Obx(
                              () => ProfileDetailRow(
                                title: "Dob",
                                value: DateFormatter().formatMillisecondsToDOB(
                                  controller.user.value.dateOfBirth,
                                ),
                              ),
                            ),
                            Obx(
                              () => ProfileDetailRow(
                                title: "Address",
                                value: controller.user.value.address,
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            const KpiScoreCard(
                              score: "87",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 0),
                              blurRadius: 1,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: MyCacheImage(
                          imageUrl: controller.user.value.image ?? "",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.paddingS8),
                Obx(
                  () => AttendanceProfileCard(
                    size: size,
                    totalAttendance: controller.totalAttendance.value,
                    totalAbsent: controller.totalAbsent.value,
                    totalLeave: controller.totalLeave.value,
                  ),
                ),
                const SizedBox(height: AppSize.paddingS11),
                ...List.generate(
                  controller.options.length,
                  (index) => OptionButton(
                    option: controller.options[index],
                    size: size,
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
