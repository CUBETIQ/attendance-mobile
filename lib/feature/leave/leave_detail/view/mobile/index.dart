import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/leave/leave_detail/controller/index.dart';
import 'package:attendance_app/feature/leave/leave_detail/widget/leave_detail_card.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_util.dart';
import 'package:attendance_app/utils/types_helper/leave_duration_type.dart';
import 'package:attendance_app/utils/types_helper/leave_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/button/back_button.dart';
import '../../../../../core/widgets/text/app_bar_title.dart';

class LeaveDetailViewMobile extends StatelessWidget {
  const LeaveDetailViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LeaveDetailController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Leave Detail",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeUtils.scale(
                AppSize.paddingHorizontalLarge,
                size.width,
              ),
              right: SizeUtils.scale(
                AppSize.paddingHorizontalLarge,
                size.width,
              ),
              top: AppSize.paddingTitleSmall,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.scale(
                  AppSize.paddingHorizontalLarge,
                  size.width,
                ),
                vertical: SizeUtils.scale(
                  AppSize.paddingVerticalMedium,
                  size.width,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  SizeUtils.scale(
                    AppSize.borderRadiusMedium,
                    size.width,
                  ),
                ),
                color: Theme.of(context).colorScheme.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeaveDetailCard(
                    title: "Type: ",
                    value: controller.leave.value.type?.capitalizeFirst,
                    valueStyle: BodyLargeMedium.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  LeaveDetailCard(
                    title: "Status: ",
                    value: controller.leave.value.status?.capitalizeFirst,
                    valueStyle: BodyLargeMedium.copyWith(
                      color:
                          controller.leave.value.status == LeaveStatus.pending
                              ? const Color(0XFFBF9705)
                              : controller.leave.value.status ==
                                      LeaveStatus.approved
                                  ? Colors.green
                                  : Colors.red,
                    ),
                  ),
                  LeaveDetailCard(
                    title: "Date: ",
                    value:
                        "${DateFormatter().formatMillisecondsToDOB(controller.leave.value.from)} - ${DateFormatter().formatMillisecondsToDOB(controller.leave.value.to)}",
                  ),
                  LeaveDetailCard(
                    title: "Duration: ",
                    value: (controller.leave.value.duration ?? 0) <= 1440
                        ? controller.leave.value.durationType ==
                                LeaveTypeDuration.fullDay
                            ? "1 day"
                            : "0.5 day"
                        : DateFormatter().formatMinutesToDays(
                            controller.leave.value.duration ?? 0),
                  ),
                  LeaveDetailCard(
                    title: controller.leave.value.status == LeaveStatus.approved
                        ? "Approved By: "
                        : controller.leave.value.status == LeaveStatus.rejected
                            ? "Rejected By: "
                            : "Pending Approval: ",
                    child: Row(
                      children: [
                        MyCacheImage(
                          imageUrl:
                              controller.leave.value.updateBy?["image"] ?? "",
                          width: SizeUtils.scale(45, size.width),
                          height: SizeUtils.scale(45, size.width),
                        ),
                        SizedBox(
                          width: SizeUtils.scale(AppSize.paddingS5, size.width),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: SizeUtils.scale(200, size.width),
                          ),
                          child: MyText(
                            text: controller.leave.value.updateBy?["name"] ??
                                "-----",
                            style: BodyLargeMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  LeaveDetailCard(
                    title: "Reason: ",
                    value: controller.leave.value.reason != "" &&
                            controller.leave.value.reason != null
                        ? controller.leave.value.reason ?? "-----"
                        : "-----",
                    noDivider: true,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
