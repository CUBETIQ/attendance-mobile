import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/task_model.dart';
import 'package:timesync/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:timesync/core/widgets/dropdown_button/dropdown_button.dart';
import 'package:timesync/core/widgets/no_data/no_data.dart';
import 'package:timesync/core/widgets/pie_chart/pie_chart.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/feature/task/task/controller/index.dart';
import 'package:timesync/feature/task/task/widget/task_card.dart';
import 'package:timesync/types/task_filter.dart';
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
                  firstTitle: "To do",
                  // secondTitle: "In_Progress",
                  thirdTitle: "Completed",
                  firstPercentage: controller.percentageTodoTask.value,
                  // secondPercentage: controller.percentageProgressTask.value,
                  thirdPercentage: controller.percentageCompletedTask.value,
                  haveNoData: controller.haveNoData.value,
                  firstColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  thirdColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: SizeUtils.scale(20, size.width),
                    bottom: SizeUtils.scale(12, size.width)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                        text: "Tasks List",
                        style: AppFonts.TitleMedium.copyWith(
                            color: Theme.of(context).colorScheme.onBackground)),
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
                        value: controller.selectedTaskType.value,
                        hint: "Choose Type",
                        dropdownItems: controller.taskType
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
                        onChanged: controller.onChangedTaskType,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  List<TaskModel> tasks =
                      controller.selectedTaskType.value == TaskFilter.pending
                          ? controller.pendingTasks.value
                          : controller.selectedTaskType.value ==
                                  TaskFilter.completed
                              ? controller.completedTasks.value
                              : controller.allTasksNoComplete;
                  return MyAsyncWidget(
                    isLoading: false,
                    list: controller.selectedTaskType.value != TaskFilter.all
                        ? tasks
                        : [
                            ...controller.allTasksNoComplete,
                            ...controller.completedTasks
                          ],
                    noDataWidget: const MyNoData(),
                    builderWidget: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            itemCount: tasks.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => SizedBox(
                              height: SizeUtils.scale(8, size.width),
                            ),
                            itemBuilder: (context, index) {
                              TaskModel? task = tasks[index];
                              return TaskCard(
                                task: task,
                                onTap: () => controller.onTapTask(task),
                                onCheck: () =>
                                    controller.completeTask(task.id!),
                              );
                            },
                          ),
                          controller.selectedTaskType.value != TaskFilter.all
                              ? const SizedBox.shrink()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeUtils.scale(12, size.width)),
                                      child: MyText(
                                        text: 'Completed',
                                        style: AppFonts.TitleMedium.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                      ),
                                    ),
                                    ListView.separated(
                                      itemCount:
                                          controller.completedTasks.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height: SizeUtils.scale(
                                          AppSize().paddingS6,
                                          size.width,
                                        ),
                                      ),
                                      itemBuilder: (context, index) {
                                        return TaskCard(
                                          task:
                                              controller.completedTasks[index],
                                          onTap: () => controller.onTapTask(
                                            controller.completedTasks[index],
                                          ),
                                          onCheck: () =>
                                              controller.completeTask(
                                            controller
                                                .completedTasks[index].id!,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
