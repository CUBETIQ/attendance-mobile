import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/async_widget/async_base_widget.dart';
import 'package:attendance_app/core/widgets/no_data/no_data.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/task/task/controller/index.dart';
import 'package:attendance_app/feature/task/task/widget/circle_progress_indicator.dart';
import 'package:attendance_app/feature/task/task/widget/task_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class TaskViewMobile extends StatelessWidget {
  const TaskViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TaskController.to;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSize.paddingHorizontalLarge,
          horizontal: AppSize.paddingVerticalLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Obx(
                    () => CircleProgressIndicator(
                      title: "Pending",
                      size: size,
                      radius: 60,
                      centerWidget: MyText(
                        text:
                            "${controller.totalUncompletedTask}/${controller.totalTask.value}",
                        style: BodyMediumRegular,
                      ),
                      percent: controller.percentageUncompletedTask.value,
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                Expanded(
                  child: Obx(
                    () => CircleProgressIndicator(
                      title: "Completed",
                      size: size,
                      radius: 60,
                      centerWidget: MyText(
                        text:
                            "${controller.totalCompletedTask}/${controller.totalTask.value}",
                        style: BodyMediumRegular,
                      ),
                      percent: controller.percentageCompletedTask.value,
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
                  separatorBuilder: (context, index) =>
                      SizedBox(height: AppSize.paddingS5 * (size.width / 375)),
                  itemBuilder: (context, index) {
                    return TaskCard(
                      task: controller.tasks[index],
                      onTap: null,
                      onCheck: (value) =>
                          controller.completeTask(controller.tasks[index].id!),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
