import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/color.dart';
import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/card/my_card.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/image/cache_image_organization.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/organization/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../widget/overview_card.dart';

class OrganizationViewMobile extends StatelessWidget {
  const OrganizationViewMobile({super.key});

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
        elevation: 2,
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  //parent container for the background
                  MyCard(
                    width: size.width,
                    height: SizeUtils.scale(160, size.width),
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: const [],
                  ),
                  //blue container on the back
                  MyCard(
                    width: size.width,
                    height: SizeUtils.scale(90, size.width),
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: const [],
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  //front content
                  Positioned(
                    top: SizeUtils.scale(30, size.width),
                    child: MyCard(
                      width: size.width,
                      height: SizeUtils.scale(130, size.width),
                      boxShadow: const [],
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.scale(
                          AppSize.paddingHorizontalLarge,
                          size.width,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(0),
                      backgroundColor: Colors.transparent,
                      child: MyCard(
                        width: size.width,
                        padding: EdgeInsets.all(
                          SizeUtils.scale(
                            15,
                            size.width,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeUtils.scale(14, size.width),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(0.15),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        child: Row(
                          children: [
                            Obx(
                              () => MyCacheImageOrganization(
                                imageUrl: controller.organization.value.image,
                                width: SizeUtils.scale(100, size.width),
                                height: SizeUtils.scale(100, size.width),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: SizeUtils.scale(2, size.width),
                                ),
                              ),
                            ),
                            SizedBox(width: SizeUtils.scale(50, size.width)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          SizeUtils.scale(145, size.width),
                                    ),
                                    child: MyText(
                                      text:
                                          controller.organization.value.name ??
                                              "Organization Name",
                                      style: BodyLargeRegular.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeUtils.scale(6, size.width),
                                ),
                                Row(
                                  children: [
                                    Obx(
                                      () => MyCacheImage(
                                        imageUrl: NavigationController
                                            .to.user.value.image,
                                        width: SizeUtils.scale(22, size.width),
                                        height: SizeUtils.scale(22, size.width),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeUtils.scale(5, size.width),
                                    ),
                                    Obx(
                                      () => Container(
                                        constraints: BoxConstraints(
                                          maxWidth:
                                              SizeUtils.scale(120, size.width),
                                        ),
                                        child: MyText(
                                          text: NavigationController
                                                  .to.fullname.value ??
                                              "User Name",
                                          style: BodySmallRegular.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeUtils.scale(6, size.width),
                                ),
                                MyButton(
                                  title: "Edit",
                                  width: SizeUtils.scale(100, size.width),
                                  height: SizeUtils.scale(30, size.width),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeUtils.scale(20, size.width)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.scale(
                    AppSize.paddingHorizontalLarge,
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
                    SizedBox(height: SizeUtils.scale(20, size.width)),
                    MyCard(
                      width: size.width,
                      height: SizeUtils.scale(350, size.width),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.scale(
                          AppSize.paddingHorizontalMedium,
                          size.width,
                        ),
                        vertical: SizeUtils.scale(
                          AppSize.paddingVerticalLarge,
                          size.width,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeUtils.scale(14, size.width),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.login_rounded,
                                        color: MyColor.successColor,
                                      ),
                                      SizedBox(
                                        width: SizeUtils.scale(5, size.width),
                                      ),
                                      MyText(
                                        text: "Start Hour",
                                        style: BodyMediumMedium,
                                      ),
                                    ],
                                  ),
                                  MyText(
                                    text: controller.organization.value.configs
                                            ?.startHour ??
                                        "00:00",
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.logout_rounded,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                      SizedBox(
                                        width: SizeUtils.scale(5, size.width),
                                      ),
                                      MyText(
                                        text: "End Hour",
                                        style: BodyMediumMedium,
                                      ),
                                    ],
                                  ),
                                  MyText(
                                    text: controller.organization.value.configs
                                            ?.endHour ??
                                        "00:00",
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.coffee_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      SizedBox(
                                        width: SizeUtils.scale(5, size.width),
                                      ),
                                      MyText(
                                        text: "Break Time",
                                        style: BodyMediumMedium,
                                      ),
                                    ],
                                  ),
                                  MyText(
                                    text: controller.organization.value.configs
                                            ?.breakTime ??
                                        "00:00",
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
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
