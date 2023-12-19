import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/color.dart';
import 'package:attendance_app/core/model/task_model.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/types_helper/task_status.dart';
import 'package:attendance_app/utils/types_helper/task_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final void Function()? onTap;
  final void Function(bool?)? onCheck;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.borderRadiusLarge * (size.width / 375),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.17),
              spreadRadius: 1.1,
              blurRadius: 1.1,
              offset: const Offset(0, 0),
            ),
          ],
          color: Theme.of(context).colorScheme.background,
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: size.width * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      AppSize.borderRadiusLarge * (size.width / 375),
                    ),
                    bottomLeft: Radius.circular(
                      AppSize.borderRadiusLarge * (size.width / 375),
                    ),
                  ),
                  color: task.taskType == TaskType.bug
                      ? const Color(MyColor.error).withOpacity(0.75)
                      : task.taskType == TaskType.feature
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.75)
                          : const Color(MyColor.success).withOpacity(0.75),
                ),
              ),
              const SizedBox(width: AppSize.paddingS5),
              Container(
                constraints: BoxConstraints(
                  maxWidth: size.width * 0.60,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.paddingS4 * (size.width / 375),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30 * (size.width / 375),
                          height: 30 * (size.width / 375),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: task.taskType == TaskType.bug
                                ? const Color(MyColor.error).withOpacity(0.75)
                                : task.taskType == TaskType.feature
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.75)
                                    : const Color(MyColor.success)
                                        .withOpacity(0.75),
                          ),
                          child: Icon(
                            task.taskType == TaskType.bug
                                ? Icons.bug_report
                                : task.taskType == TaskType.feature
                                    ? Icons.task
                                    : Icons.featured_play_list,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: AppSize.paddingS5),
                        MyText(
                          text:
                              (task.taskType ?? "Task Type").capitalizeFirst ??
                                  "",
                          maxLines: 1,
                          style: BodyLarge.copyWith(
                            color: task.taskType == TaskType.bug
                                ? const Color(MyColor.error).withOpacity(0.75)
                                : task.taskType == TaskType.feature
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.75)
                                    : const Color(MyColor.success)
                                        .withOpacity(0.75),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.paddingS1 * (size.width / 375)),
                    MyText(
                      text: task.taskName ?? "Task Name",
                      maxLines: 1,
                      style: BodyLargeMedium,
                    ),
                    SizedBox(height: AppSize.paddingS1 * (size.width / 375)),
                    MyText(
                      text: task.taskDescription ?? "Task Description",
                      maxLines: 5,
                      style: BodyMediumRegular.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    SizedBox(height: AppSize.paddingS1 * (size.width / 375)),
                    MyText(
                      text: "Due To: 11/11/2023",
                      style: BodySmallRegular.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSize.paddingS5 * (size.width / 375),
                    horizontal: AppSize.paddingS5 * (size.width / 375),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 24 * (size.width / 375.0),
                        height: 24 * (size.width / 375.0),
                        child: Checkbox(
                          value: task.taskStatus == TaskStatus.completed
                              ? true
                              : false,
                          onChanged: onCheck,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5 * (size.width / 375.0),
                            ),
                          ),
                          splashRadius: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
