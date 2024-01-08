import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/staff/staff_detail/controller/index.dart';
import 'package:attendance_app/feature/staff/staff_detail/widget/info_detail_card.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_formater.dart';
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize.paddingHorizontalLarge,
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
                        text:
                            "${controller.staff.value.firstName ?? controller.staff.value.username ?? ""} "
                            "${controller.staff.value.lastName ?? ""}",
                        style: BodyXlargeSemi.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      MyText(
                        text: controller.position.value.name ?? "No Position",
                        style: BodyMediumRegular.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: SizeUtils.scale(25, size.width)),
              InfoDetailCard(
                title: "First Name",
                value: controller.staff.value.firstName,
              ),
              InfoDetailCard(
                title: "Last Name",
                value: controller.staff.value.lastName,
              ),
              InfoDetailCard(
                title: "Department",
                value: controller.department.value.name,
              ),
              Row(
                children: [
                  Expanded(
                    child: InfoDetailCard(
                      title: "Gender",
                      value: controller.staff.value.gender,
                    ),
                  ),
                  SizedBox(width: SizeUtils.scale(10, size.width)),
                  Expanded(
                    child: InfoDetailCard(
                      title: "Date Of Birth",
                      value: DateFormatter().formatMillisecondsToDOB(
                        controller.staff.value.dateOfBirth,
                      ),
                    ),
                  ),
                ],
              ),
              InfoDetailCard(
                title: "Address",
                value: controller.staff.value.address,
              ),
              InfoDetailCard(
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
