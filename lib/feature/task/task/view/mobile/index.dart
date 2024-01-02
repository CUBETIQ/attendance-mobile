import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/async_widget/async_base_widget.dart';
import 'package:attendance_app/core/widgets/no_data/no_data.dart';
import 'package:attendance_app/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/task/task/controller/index.dart';
import 'package:attendance_app/feature/task/task/widget/task_chart.dart';
import 'package:attendance_app/feature/task/task/widget/task_card.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class TaskViewMobile extends StatelessWidget {
  const TaskViewMobile({super.key});

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
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeUtils.scale(
                AppSize.paddingHorizontalLarge,
                MediaQuery.of(context).size.width,
              ),
              horizontal: AppSize.paddingVerticalLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: "Task Summary", style: BodyLargeMedium),
                const SizedBox(height: AppSize.paddingS8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(
                        () => TaskChart(
                          title: "Pending",
                          size: size,
                          radius: 60,
                          centerWidget: MyText(
                            text:
                                "${(controller.percentageUncompletedTask.value * 100).toStringAsFixed(2)}%",
                            style: BodyMediumRegular,
                          ),
                          percent: controller.percentageUncompletedTask.value,
                          textBelow:
                              "Task: ${controller.totalUncompletedTask}/${controller.totalTask.value}",
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: Obx(
                        () => TaskChart(
                          title: "Completed",
                          size: size,
                          radius: 60,
                          centerWidget: MyText(
                            text:
                                "${(controller.percentageCompletedTask.value * 100).toStringAsFixed(2)}%",
                            style: BodyMediumRegular,
                          ),
                          percent: controller.percentageCompletedTask.value,
                          textBelow:
                              "Task: ${controller.totalCompletedTask}/${controller.totalTask.value}",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.paddingS11),
                MyText(text: "MyTask", style: BodyLargeMedium),
                const SizedBox(height: AppSize.paddingS8),
                Obx(
                  () => MyAsyncWidget(
                    isLoading: false,
                    list: controller.tasks,
                    noDataWidget: const MyNoData(),
                    builderWidget: ListView.separated(
                      itemCount: controller.tasks.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                        height: SizeUtils.scale(
                          AppSize.paddingS5,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
