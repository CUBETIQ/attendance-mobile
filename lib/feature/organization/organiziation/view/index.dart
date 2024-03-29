import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/organization/organiziation/controller/index.dart';
import 'package:timesync/feature/organization/organiziation/widget/company_profile_card.dart';
import 'package:timesync/feature/organization/organiziation/widget/info_data_column.dart';
import 'package:timesync/feature/organization/organiziation/widget/overview_card.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';

class OrganizationView extends StatelessWidget {
  const OrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrganizationController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(title: "Organization"),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SizeUtils.scale(10, size.width)),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.GENERATE_QR);
              },
              child: SvgPicture.asset(
                SvgAssets.qr,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onBackground,
                    BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => CompanyProfileCard(
                  companyName: controller.organization.value.name,
                  companyLogo: controller.organization.value.image,
                  companyOwner: NavigationController.to.user.value,
                  onTapEdit: controller.onTabEdit,
                ),
              ),
              SizedBox(height: SizeUtils.scale(20, size.width)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.scale(
                    AppSize().paddingHorizontalLarge,
                    size.width,
                  ),
                ),
                child: Column(
                  children: [
                    Obx(
                      () => OverViewCard(
                        staffs: controller.staffs.length,
                        totalStaff: controller.organization.value.limitStaff,
                        totalDepartment: controller.departments.length,
                        totalPosition: controller.positions.length,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeUtils.scale(20, size.width),
                          bottom: SizeUtils.scale(10, size.width)),
                      child: MyCard(
                        width: size.width,
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeUtils.scale(
                            AppSize().paddingHorizontalMedium,
                            size.width,
                          ),
                          vertical: SizeUtils.scale(
                            AppSize().paddingVerticalLarge,
                            size.width,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeUtils.scale(14, size.width),
                        ),
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InfoDataColumn(
                                          icon: Icons.login_rounded,
                                          iconColor: MyColor.successColor,
                                          title: "Start Hour",
                                          value: controller.organization.value
                                                  .configs?.startHour ??
                                              "00:00",
                                        ),
                                        InfoDataColumn(
                                          icon: Icons.coffee_rounded,
                                          iconColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          title: "Break Time",
                                          value:
                                              "${controller.organization.value.configs?.breakTime?.split("-")[0]} - ${DateUtil.formatTimeTo12Hour(
                                            controller.organization.value
                                                    .configs?.breakTime
                                                    ?.split("-")[1] ??
                                                "00:00",
                                            dontShowAMPM: true,
                                          )}",
                                        ),
                                        InfoDataColumn(
                                          icon: Icons.location_on_rounded,
                                          iconColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          title: "Company's Address",
                                          value: controller
                                                  .organization.value.address ??
                                              "-",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InfoDataColumn(
                                          icon: Icons.logout_rounded,
                                          iconColor: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          title: "End Hour",
                                          value: DateUtil.formatTimeTo12Hour(
                                            controller.organization.value
                                                    .configs?.endHour ??
                                                "00:00",
                                            dontShowAMPM: true,
                                          ),
                                        ),
                                        InfoDataColumn(
                                          icon: Icons.timer_rounded,
                                          iconColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          title: "Break Duration",
                                          value: DateUtil.calculateDuration(
                                              controller.organization.value
                                                  .configs?.breakTime
                                                  ?.split("-")[0],
                                              controller.organization.value
                                                  .configs?.breakTime
                                                  ?.split("-")[1]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              InfoDataColumn(
                                icon: Icons.description_rounded,
                                iconColor:
                                    Theme.of(context).colorScheme.primary,
                                title: "Description",
                                value:
                                    controller.organization.value.description ??
                                        "-",
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
