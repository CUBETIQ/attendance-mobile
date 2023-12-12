import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/profile/controller/index.dart';
import 'package:attendance_app/feature/profile/widget/attendance_profile_card.dart';
import 'package:attendance_app/feature/profile/widget/job_company_title.dart';
import 'package:attendance_app/feature/profile/widget/kpi_score_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileViewMobile extends StatelessWidget {
  const ProfileViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProfileController.to;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSize.paddingHorizontalLarge,
          right: AppSize.paddingHorizontalLarge,
          top: AppSize.paddingTitleSmall,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: size.width * 0.8,
                  width: size.width,
                ),
                Positioned(
                  top: 65,
                  child: Container(
                    height: size.width * 0.63,
                    width: size.width - 48,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.paddingHorizontalLarge,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSize.borderRadiusLarge * (size.width / 375),
                      ),
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.15),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: size.width * 0.12),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: size.width * 0.7,
                          ),
                          child: MyText(
                            text: controller.name.value ?? "--------",
                            style: BodyXlargeMedium,
                          ),
                        ),
                        SizedBox(height: size.height * 0.005),
                        Obx(
                          () => JobCompanyTitle(
                            organization: NavigationController
                                    .to.organization.value.name ??
                                "Comapny",
                            position:
                                NavigationController.to.position.value.name ??
                                    "Position",
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
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
            AttendanceProfileCard(
              size: size,
              totalAttendance: "10",
              totalAbsent: "2",
              totalLeave: "1",
            ),
            const SizedBox(height: AppSize.paddingS11),
            ...List.generate(
              controller.options.length,
              (index) => Container(
                width: size.width,
                height: size.width * 0.15,
                margin: const EdgeInsets.only(
                  bottom: AppSize.paddingS5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppSize.borderRadiusLarge * (size.width / 375),
                  ),
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.065),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
