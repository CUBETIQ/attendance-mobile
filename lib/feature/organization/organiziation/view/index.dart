import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/organization/organiziation/controller/index.dart';
import 'package:timesync/feature/organization/organiziation/widget/company_profile_card.dart';
import 'package:timesync/feature/organization/organiziation/widget/info_data_column.dart';
import 'package:timesync/feature/organization/organiziation/widget/overview_card.dart';
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
                      padding: EdgeInsets.symmetric(
                          vertical: SizeUtils.scale(20, size.width)),
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
                                children: [
                                  Column(
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
                                        value: controller.organization.value
                                                .configs?.breakTime ??
                                            "00:00",
                                      ),
                                      InfoDataColumn(
                                        icon: Icons.location_on_rounded,
                                        iconColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        title: "Company's Address",
                                        value: controller
                                                .organization.value.address ??
                                            "N/A",
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InfoDataColumn(
                                        icon: Icons.logout_rounded,
                                        iconColor:
                                            Theme.of(context).colorScheme.error,
                                        title: "End Hour",
                                        value: controller.organization.value
                                                .configs?.endHour ??
                                            "00:00",
                                      ),
                                      InfoDataColumn(
                                        icon: Icons.timer_rounded,
                                        iconColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        title: "Break Duration",
                                        value: controller.organization.value
                                                .configs?.breakDuration ??
                                            "00:00",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: SizeUtils.scale(15, size.width)),
                              InfoDataColumn(
                                icon: Icons.description_rounded,
                                iconColor:
                                    Theme.of(context).colorScheme.primary,
                                title: "Description",
                                value:
                                    controller.organization.value.description ??
                                        "N/A",
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
