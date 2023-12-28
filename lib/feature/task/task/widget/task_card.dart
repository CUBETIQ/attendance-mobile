import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/task_model.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/extensions/string.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_formater.dart';
import 'package:attendance_app/utils/types_helper/task_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final void Function()? onTap;
  final void Function(bool?)? onCheck;
  final String? color;
  final String? icon;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onCheck,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: task.taskStatus == TaskStatus.completed ? null : onTap,
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeUtils.scaleWidth(AppSize.borderRadiusLarge, size.width),
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
                      SizeUtils.scaleWidth(
                        AppSize.borderRadiusLarge,
                        size.width,
                      ),
                    ),
                    bottomLeft: Radius.circular(
                      SizeUtils.scaleWidth(
                        AppSize.borderRadiusLarge,
                        size.width,
                      ),
                    ),
                  ),
                  color: color != null
                      ? Color(color!.toInt())
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                width: SizeUtils.scaleWidth(AppSize.paddingS8, size.width),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: size.width * 0.67,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: SizeUtils.scaleWidth(AppSize.paddingS4, size.width),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: SizeUtils.scaleWidth(30, size.width),
                          height: SizeUtils.scaleWidth(30, size.width),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color != null
                                ? Color(color!.toInt())
                                : Theme.of(context).colorScheme.primary,
                          ),
                          child: Icon(
                            task.icon?.isEmpty == false || icon != null
                                ? IconData(task.icon!.toInt(),
                                    fontFamily: 'MaterialIcons')
                                : Icons.task,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: AppSize.paddingS5),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: size.width * 0.56,
                          ),
                          child: MyText(
                            text:
                                (task.taskName ?? "Task Name").capitalizeFirst,
                            maxLines: 2,
                            style: BodyLarge.copyWith(
                              color: color != null
                                  ? Color(color!.toInt())
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:
                          SizeUtils.scaleWidth(AppSize.paddingS1, size.width),
                    ),
                    task.taskDescription == null || task.taskDescription == ""
                        ? const SizedBox.shrink()
                        : MyText(
                            text: task.taskDescription ?? "Task Description",
                            maxLines: 5,
                            style: BodyMediumRegular.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                    SizedBox(
                      height:
                          SizeUtils.scaleWidth(AppSize.paddingS1, size.width),
                    ),
                    MyText(
                      text: task.endDate != null
                          ? "Due: ${DateFormatter().formatMillisecondsToDOB(task.endDate!)}"
                          : "Due: N/A",
                      style: BodyXSmallRegular.copyWith(
                        color: task.taskStatus == TaskStatus.completed
                            ? Theme.of(context).colorScheme.outline
                            : Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical:
                        SizeUtils.scaleWidth(AppSize.paddingS5, size.width),
                    horizontal:
                        SizeUtils.scaleWidth(AppSize.paddingS5, size.width),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IgnorePointer(
                        ignoring: task.taskStatus == TaskStatus.completed
                            ? true
                            : false,
                        child: SizedBox(
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
