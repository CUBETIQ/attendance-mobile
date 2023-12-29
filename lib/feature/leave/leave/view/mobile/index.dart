import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/async_widget/async_base_widget.dart';
import 'package:attendance_app/core/widgets/no_data/no_data.dart';
import 'package:attendance_app/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/leave/leave/controller/index.dart';
import 'package:attendance_app/feature/leave/leave/widget/leave_card.dart';
import 'package:attendance_app/feature/leave/leave/widget/leave_chart.dart';
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
            padding: const EdgeInsets.only(
              left: AppSize.paddingHorizontalLarge,
              right: AppSize.paddingHorizontalLarge,
              top: AppSize.paddingVerticalLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: "Task Summary", style: BodyLargeMedium),
                const SizedBox(height: AppSize.paddingS10),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => LeaveChart(
                          title: "Pending",
                          radius: 35,
                          centerText:
                              "${(controller.percentagePendingLeave.value * 100).toStringAsFixed(2)} %",
                          percent: controller.percentagePendingLeave.value,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: Obx(
                        () => LeaveChart(
                          title: "Approved",
                          radius: 35,
                          centerText:
                              "${(controller.percentageApprovedLeave.value * 100).toStringAsFixed(2)} %",
                          percent: controller.percentageApprovedLeave.value,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: Obx(
                        () => LeaveChart(
                          title: "Declined",
                          radius: 35,
                          centerText:
                              "${(controller.percentageDeclinedLeave.value * 100).toStringAsFixed(2)} %",
                          percent: controller.percentageDeclinedLeave.value,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.paddingS14),
                Row(
                  children: [
                    MyText(
                      text: "My Request",
                      style: BodyLargeMedium,
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.paddingS10),
                Obx(
                  () => MyAsyncWidget(
                    isLoading: controller.isLoading.value,
                    list: controller.leave,
                    noDataWidget: const MyNoData(),
                    builderWidget: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.leave.length,
                      itemBuilder: (context, index) {
                        return LeaveCard(
                          onTap: () => controller.onTapLeave(
                            controller.leave[index],
                          ),
                          leave: controller.leave[index],
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
