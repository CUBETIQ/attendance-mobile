import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync360/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:timesync360/core/widgets/no_data/no_data.dart';
import 'package:timesync360/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/leave/leave/controller/index.dart';
import 'package:timesync360/feature/leave/leave/widget/leave_card.dart';
import 'package:timesync360/feature/leave/leave/widget/leave_chart.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveViewMobile extends StatelessWidget {
  const LeaveViewMobile({super.key});

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
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                        text: "Leave Summary",
                        style: AppStyles().bodyLargeMedium),
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
                  children: [
                    Expanded(
                      child: Obx(
                        () => LeaveChart(
                          title: "Pending",
                          radius: 38,
                          centerText:
                              "${(controller.percentagePendingLeave.value * 100).toStringAsFixed(controller.percentagePendingLeave.value == 0 ? 0 : 2)}%",
                          percent: controller.percentagePendingLeave.value,
                          textBelow: "${controller.totalPendingLeave.value}/"
                              "${controller.totalLeave.value}",
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: Obx(
                        () => LeaveChart(
                          title: "Approved",
                          radius: 38,
                          centerText:
                              "${(controller.percentageApprovedLeave.value * 100).toStringAsFixed(controller.percentageApprovedLeave.value == 0 ? 0 : 2)}%",
                          percent: controller.percentageApprovedLeave.value,
                          textBelow: "${controller.totalApprovedLeave.value}/"
                              "${controller.totalLeave.value}",
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: Obx(
                        () => LeaveChart(
                          title: "Rejected",
                          radius: 38,
                          centerText:
                              "${(controller.percentageDeclinedLeave.value * 100).toStringAsFixed(controller.percentageDeclinedLeave.value == 0 ? 0 : 2)}%",
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
                      style: AppStyles().bodyLargeMedium,
                    ),
                  ],
                ),
                SizedBox(height: AppSize().paddingS10),
                Obx(
                  () => MyAsyncWidget(
                    isLoading: controller.isLoading.value,
                    list: controller.leaves,
                    noDataWidget: const MyNoData(),
                    builderWidget: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
