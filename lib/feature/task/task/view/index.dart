import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:timesync/core/widgets/no_data/no_data.dart';
import 'package:timesync/core/widgets/pie_chart/pie_chart.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/task/task/controller/index.dart';
import 'package:timesync/feature/task/task/widget/task_card.dart';
import 'package:timesync/utils/size_util.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TaskController.to;
    final size = MediaQuery.of(context).size;
    return MyRefreshIndicator(
      onRefresh: () async {
        controller.onRefresh();
      },
      child: SizedBox(
        height: size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize().paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeUtils.scale(22, size.width),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: "Task Summary",
                    style: AppFonts.TitleMedium.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
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
                  firstTitle: "Todo",
                  secondTitle: "In_Progress",
                  thirdTitle: "Completed",
                  firstPercentage: controller.percentageTodoTask.value,
                  secondPercentage: controller.percentageProgressTask.value,
                  thirdPercentage: controller.percentageCompletedTask.value,
                  haveNoData: controller.haveNoData.value,
                  firstColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  thirdColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: SizeUtils.scale(20, size.width)),
              Row(
                children: [
                  MyText(text: "Tasks List", style: AppFonts().bodyLargeMedium),
                ],
              ),
              SizedBox(height: AppSize().paddingS8),
              Expanded(
                child: Obx(
                  () => MyAsyncWidget(
                    isLoading: false,
                    list: controller.tasks,
                    noDataWidget: const MyNoData(),
                    builderWidget: ListView.separated(
                      itemCount: controller.tasks.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        height: SizeUtils.scale(
                          AppSize().paddingS6,
                          size.width,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        return TaskCard(
                          color: controller.tasks[index].color,
                          task: controller.tasks[index],
                          onTap: () => controller.onTapTask(
                            controller.tasks[index],
                          ),
                          onCheck: (value) => controller.completeTask(
                            controller.tasks[index].id!,
                          ),
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
