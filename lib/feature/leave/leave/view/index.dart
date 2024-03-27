import 'package:get/get.dart';
import 'package:timesync/constants/app_shadow.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:timesync/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync/core/widgets/no_data/no_data.dart';
import 'package:timesync/core/widgets/pie_chart/pie_chart.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/feature/leave/leave/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:timesync/feature/leave/leave/widget/leave_card.dart';
import 'package:timesync/utils/size_util.dart';

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
              Obx(
                () => MyPieChart(
                  firstPercentage: controller.percentagePendingLeave.value,
                  secondPercentage: controller.percentageApprovedLeave.value,
                  thirdPercentage: controller.percentageDeclinedLeave.value,
                  haveNoData: controller.leaves.value.isEmpty,
                  firstTitle: "Awaiting",
                  secondTitle: "Approved",
                  thirdTitle: "Declined",
                  rightPadding: 60,
                  firstColor: Theme.of(context).colorScheme.tertiaryContainer,
                  secondColor: Theme.of(context).colorScheme.tertiary,
                  thirdColor: Theme.of(context).colorScheme.error,
                  pieChartShadow: [
                    AppShadow.shadowWithColor(
                      Theme.of(context).colorScheme.primary,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeUtils.scale(20, size.width)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: "My Leave Requests",
                    style: AppFonts.TitleMedium,
                  ),
                  Obx(
                    () => MyDropDownButton<String>(
                      width: SizeUtils.scale(130, size.width),
                      borderColor: Theme.of(context).colorScheme.primary,
                      buttonPadding: EdgeInsets.only(
                        left: SizeUtils.scale(0, size.width),
                        right: SizeUtils.scale(10, size.width),
                        top: SizeUtils.scale(1, size.width),
                        bottom: SizeUtils.scale(1, size.width),
                      ),
                      dropdownPadding: EdgeInsets.symmetric(
                          horizontal: SizeUtils.scale(10, size.width)),
                      borderRadius: SizeUtils.scale(24, size.width),
                      label: "Type",
                      hasLabel: false,
                      value: controller.selectedLeaveType.value,
                      hint: "Choose Type",
                      dropdownItems: controller.leaveType
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: MyText(
                                text: e.trString,
                                style: AppFonts.TitleXSmall.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: controller.onChangedLeaveType,
                    ),
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
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.leaves.length,
                      padding: EdgeInsets.all(SizeUtils.scale(1, size.width)),
                      itemBuilder: (context, index) {
                        return LeaveCard(
                          onTap: () => controller.onTapLeave(
                            controller.leaves[index],
                          ),
                          leave: controller.leaves[index],
                          onTapView: () => controller.onTapView(index),
                          onTapCancel: () =>
                              controller.onTapCancel(controller.leaves[index]),
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
