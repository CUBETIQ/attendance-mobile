import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:timesync/core/widgets/no_data/no_data.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/leave/leave/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:timesync/feature/leave/leave/widget/leave_card.dart';
import 'package:timesync/feature/leave/leave/widget/leave_chart.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

class LeaveView extends StatelessWidget {
  const LeaveView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = LeaveController.to;
    final size = MediaQuery.of(context).size;
    return MyRefreshIndicator(
      onRefresh: () async {
        controller.onRefresh();
      },
      child: SizedBox(
        height: size.height,
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeUtils.scale(
              AppSize().paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
            right: SizeUtils.scale(
              AppSize().paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
            top: AppSize().paddingVerticalLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                      text: "Leave Summary", style: AppFonts().bodyLargeMedium),
                  Obx(
                    () => DateDropDown(
                      date: controller.selectDate.value,
                      size: size,
                      isShowday: false,
                      onTap: () => controller.onTapDate(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeUtils.scale(20, size.width)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Obx(
                      () => LeaveChart(
                        title: "Pending",
                        radius: size.width < 600 ? 40 : 60,
                        centerText: StringUtil.doubleToPercentageString(
                            controller.percentagePendingLeave.value * 100),
                        percent: controller.percentagePendingLeave.value,
                        textBelow: "${controller.totalPendingLeave.value}/"
                            "${controller.totalLeave.value}",
                      ),
                    ),
                  ),
                  SizedBox(width: SizeUtils.scale(8, size.width)),
                  Expanded(
                    child: Obx(
                      () => LeaveChart(
                        title: "Approved",
                        radius: size.width < 600 ? 40 : 60,
                        centerText: StringUtil.doubleToPercentageString(
                            controller.percentageApprovedLeave.value * 100),
                        percent: controller.percentageApprovedLeave.value,
                        textBelow: "${controller.totalApprovedLeave.value}/"
                            "${controller.totalLeave.value}",
                      ),
                    ),
                  ),
                  SizedBox(width: SizeUtils.scale(8, size.width)),
                  Expanded(
                    child: Obx(
                      () => LeaveChart(
                        title: "Rejected",
                        radius: size.width < 600 ? 40 : 60,
                        centerText: StringUtil.doubleToPercentageString(
                            controller.percentageDeclinedLeave.value * 100),
                        percent: controller.percentageDeclinedLeave.value,
                        textBelow: "${controller.totalDeclinedLeave.value}/"
                            "${controller.totalLeave.value}",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize().paddingS14),
              Row(
                children: [
                  MyText(
                    text: "My Request",
                    style: AppFonts().bodyLargeMedium,
                  ),
                ],
              ),
              SizedBox(height: AppSize().paddingS10),
              Expanded(
                child: Obx(
                  () => MyAsyncWidget(
                    isLoading: controller.isLoading.value,
                    list: controller.leaves,
                    noDataWidget: const MyNoData(),
                    builderWidget: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.leaves.length,
                      itemBuilder: (context, index) {
                        return LeaveCard(
                          onTap: () => controller.onTapLeave(
                            controller.leaves[index],
                          ),
                          leave: controller.leaves[index],
                          onTapView: () => controller.onTapView(index),
                          onTapCancel: () => controller
                              .onTapCancel(controller.leaves[index].id!),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
