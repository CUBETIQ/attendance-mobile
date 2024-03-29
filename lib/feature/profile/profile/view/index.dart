import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/profile/profile/controller/index.dart';
import 'package:timesync/feature/profile/profile/widget/attendance_profile_card.dart';
import 'package:timesync/feature/profile/profile/widget/job_company_title.dart';
import 'package:timesync/feature/profile/profile/widget/kpi_score_card.dart';
import 'package:timesync/feature/profile/profile/widget/option_button.dart';
import 'package:timesync/feature/profile/profile/widget/profile_detail_row.dart';
import 'package:timesync/feature/profile/profile/widget/profile_image.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

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
              left:
                  SizeUtils.scale(AppSize().paddingHorizontalLarge, size.width),
              right:
                  SizeUtils.scale(AppSize().paddingHorizontalLarge, size.width),
              top: SizeUtils.scale(AppSize().paddingS11, size.width),
            ),
            child: Column(
              children: [
                Container(
                  width: size.width - SizeUtils.scale(48, size.width),
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.scale(
                      AppSize().paddingHorizontalLarge,
                      size.width,
                    ),
                    vertical: SizeUtils.scale(
                      AppSize().paddingS11,
                      size.width,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      SizeUtils.scale(
                        AppSize().borderRadiusLarge,
                        size.width,
                      ),
                    ),
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.065),
                  ),
                  child: Column(
                    children: [
                      Obx(
                        () => ProfielImage(
                          imageUrl: controller.user.value.image,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: size.width * 0.7,
                        ),
                        child: Obx(
                          () => MyText(
                            text: StringUtil.getfullname(
                              controller.user.value.firstName,
                              controller.user.value.lastName,
                              controller.user.value.username,
                            ),
                            style: AppFonts().bodyXlargeMedium,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Obx(
                        () => JobCompanyTitle(
                          organization:
                              NavigationController.to.organization.value.name ??
                                  "Comapny",
                          position: NavigationController.to.position.value.name,
                        ),
                      ),
                      SizedBox(height: size.height * 0.015),
                      Obx(
                        () => ProfileDetailRow(
                          title: "Department",
                          value: NavigationController.to.department.value.name,
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
                          value: DateUtil.formatMillisecondsToDOB(
                            controller.user.value.dateOfBirth,
                          ),
                        ),
                      ),
                      Obx(
                        () => ProfileDetailRow(
                          title: "Address",
                          value: controller.user.value.address,
                          maxline: 2,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      const KpiScoreCard(
                        score: "100",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeUtils.scale(10, size.width)),
                  child: Obx(
                    () => AttendanceProfileCard(
                      size: size,
                      totalAttendance: controller.totalAttendance.value,
                      totalAbsent: controller.totalAbsent.value,
                      totalLeave: controller.totalLeave.value,
                    ),
                  ),
                ),
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
