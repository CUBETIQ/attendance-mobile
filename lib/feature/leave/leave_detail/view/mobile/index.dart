import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/leave/leave_detail/controller/index.dart';
import 'package:timesync360/feature/leave/leave_detail/widget/leave_detail_card.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/string_util.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:timesync360/types/leave_status.dart';
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
                AppSize().paddingHorizontalLarge,
                size.width,
              ),
              right: SizeUtils.scale(
                AppSize().paddingHorizontalLarge,
                size.width,
              ),
              top: AppSize().paddingTitleSmall,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.scale(
                  AppSize().paddingHorizontalLarge,
                  size.width,
                ),
                vertical: SizeUtils.scale(
                  AppSize().paddingVerticalMedium,
                  size.width,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  SizeUtils.scale(
                    AppSize().borderRadiusMedium,
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
                    valueStyle: AppStyles().bodyLargeMedium.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  LeaveDetailCard(
                    title: "Status: ",
                    value: controller.leave.value.status?.capitalizeFirst,
                    valueStyle: AppStyles().bodyLargeMedium.copyWith(
                          color: controller.leave.value.status ==
                                  LeaveStatus.pending
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
                        "${DateFormatter.formatMillisecondsToDOB(controller.leave.value.from)} - ${DateFormatter.formatMillisecondsToDOB(controller.leave.value.to)}",
                  ),
                  LeaveDetailCard(
                    title: "Duration: ",
                    value:
                        " ${StringUtil.removeTrailingZeros(controller.leave.value.duration)}  ${(controller.leave.value.duration ?? 0) < 2 ? "Day" : "Days"}",
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
                              controller.leave.value.updateBy?.image ?? "",
                          width: SizeUtils.scale(45, size.width),
                          height: SizeUtils.scale(45, size.width),
                        ),
                        SizedBox(
                          width:
                              SizeUtils.scale(AppSize().paddingS5, size.width),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: SizeUtils.scale(200, size.width),
                          ),
                          child: MyText(
                            text: StringUtil.getfullname(
                              controller.leave.value.updateBy?.firstName,
                              controller.leave.value.updateBy?.lastName,
                              controller.leave.value.updateBy?.username,
                            ),
                            style: AppStyles().bodyLargeMedium,
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
