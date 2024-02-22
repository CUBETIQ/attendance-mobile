import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/employee/employee_detail/controller/index.dart';
import 'package:timesync360/core/widgets/card/label_detail_card.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/string_util.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffDetailViewMobile extends StatelessWidget {
  const StaffDetailViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StaffDetailController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Detail",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize().paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: SizeUtils.scale(20, size.width)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => MyCacheImage(
                      imageUrl: controller.staff.value.image ?? "",
                      width: SizeUtils.scale(80, size.width),
                      height: SizeUtils.scale(80, size.width),
                    ),
                  ),
                  SizedBox(width: SizeUtils.scale(20, size.width)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: StringUtil.getfullname(
                          controller.staff.value.firstName,
                          controller.staff.value.lastName,
                          controller.staff.value.username,
                        ),
                        style: AppStyles().bodyXlargeSemi.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      MyText(
                        text: controller.position.value.name ?? "No Position",
                        style: AppStyles().bodyMediumRegular.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: SizeUtils.scale(25, size.width)),
              LabelDetailCard(
                title: "First Name",
                value: controller.staff.value.firstName,
              ),
              LabelDetailCard(
                title: "Last Name",
                value: controller.staff.value.lastName,
              ),
              LabelDetailCard(
                title: "Email",
                value: controller.staff.value.email,
              ),
              LabelDetailCard(
                title: "Department",
                value: controller.department.value.name,
              ),
              Row(
                children: [
                  Expanded(
                    child: LabelDetailCard(
                      title: "Gender",
                      value: controller.staff.value.gender,
                    ),
                  ),
                  SizedBox(width: SizeUtils.scale(10, size.width)),
                  Expanded(
                    child: LabelDetailCard(
                      title: "Date Of Birth",
                      value: DateFormatter.formatMillisecondsToDOB(
                        controller.staff.value.dateOfBirth,
                      ),
                    ),
                  ),
                ],
              ),
              LabelDetailCard(
                title: "Address",
                value: controller.staff.value.address,
              ),
              LabelDetailCard(
                title: "Status",
                value: controller.staff.value.status,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
