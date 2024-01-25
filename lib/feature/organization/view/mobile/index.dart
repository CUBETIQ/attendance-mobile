import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/card/my_card.dart';
import 'package:attendance_app/core/widgets/image/cache_image_organization.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/organization/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  SizeUtils.scale(AppSize.paddingHorizontalLarge, size.width),
            ),
            child: Column(
              children: [
                SizedBox(height: SizeUtils.scale(30, size.width)),
                Center(
                  child: MyCacheImageOrganization(
                    imageUrl: null,
                    width: SizeUtils.scale(85, size.width),
                    height: SizeUtils.scale(85, size.width),
                  ),
                ),
                SizedBox(height: SizeUtils.scale(10, size.width)),
                Obx(
                  () => MyText(
                    text: controller.organization.value.name ?? "",
                    style: BodyXlargeMedium,
                  ),
                ),
                SizedBox(height: SizeUtils.scale(30, size.width)),
                MyCard(
                  width: size.width,
                  height: SizeUtils.scale(100, size.width),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.scale(24, size.width),
                    vertical: SizeUtils.scale(16, size.width),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.person_rounded,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: SizeUtils.scale(25, size.width),
                          ),
                          MyText(
                            text: "Employee",
                            style: BodyMedium.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          MyText(
                            text:
                                "${controller.staffs.length}/${controller.organization.value.limitStaff ?? 0}",
                            style: BodyMedium.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.location_city,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: SizeUtils.scale(25, size.width),
                          ),
                          MyText(
                            text: "Department",
                            style: BodyMedium.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          MyText(
                            text:
                                "${controller.staffs.length}/${controller.organization.value.limitStaff ?? 0}",
                            style: BodyMedium.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.work_rounded,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: SizeUtils.scale(25, size.width),
                          ),
                          MyText(
                            text: "Position",
                            style: BodyMedium.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          MyText(
                            text:
                                "${controller.staffs.length}/${controller.organization.value.limitStaff ?? 0}",
                            style: BodyMedium.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
