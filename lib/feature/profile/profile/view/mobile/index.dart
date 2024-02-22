import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/navigation/controller/index.dart';
import 'package:timesync360/feature/profile/profile/controller/index.dart';
import 'package:timesync360/feature/profile/profile/widget/attendance_profile_card.dart';
import 'package:timesync360/feature/profile/profile/widget/job_company_title.dart';
import 'package:timesync360/feature/profile/profile/widget/kpi_score_card.dart';
import 'package:timesync360/feature/profile/profile/widget/option_button.dart';
import 'package:timesync360/feature/profile/profile/widget/profile_detail_row.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/string_util.dart';
import 'package:timesync360/utils/time_util.dart';
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
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.15),
                  ),
                  child: Column(
                    children: [
                      Container(
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
                        child: Obx(
                          () => MyCacheImage(
                            imageUrl: controller.user.value.image ?? "",
                            width: SizeUtils.scale(100, size.width),
                            height: SizeUtils.scale(100, size.width),
                          ),
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
                            style: AppStyles().bodyXlargeMedium,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Obx(
                        () => JobCompanyTitle(
                          organization:
                              NavigationController.to.organization.value.name ??
                                  "Comapny",
                          position:
                              NavigationController.to.position.value.name ??
                                  "Position",
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
                          value: DateFormatter.formatMillisecondsToDOB(
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
                SizedBox(height: AppSize().paddingS8),
                Obx(
                  () => AttendanceProfileCard(
                    size: size,
                    totalAttendance: controller.totalAttendance.value,
                    totalAbsent: controller.totalAbsent.value,
                    totalLeave: controller.totalLeave.value,
                  ),
                ),
                SizedBox(height: AppSize().paddingS11),
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
