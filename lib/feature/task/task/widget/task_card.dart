import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/task_model.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/types/task_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final void Function()? onTap;
  final void Function(bool) onCheck;
  final String? color;
  final String? icon;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    required this.onCheck,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.scale(
            AppSize().paddingHorizontalLarge,
            size.width,
          ),
          vertical: SizeUtils.scale(
            AppSize().paddingS4,
            size.width,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeUtils.scale(AppSize().borderRadiusLarge, size.width),
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          color: color != null
              ? Color(color!.toInt()).withOpacity(0.20)
              : Theme.of(context).colorScheme.primary.withOpacity(0.20),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              IgnorePointer(
                ignoring: task.status == TaskStatus.completed ? true : false,
                child: MSHCheckbox(
                  value: task.status == TaskStatus.completed ? true : false,
                  size: SizeUtils.scale(20, size.width),
                  onChanged: onCheck,
                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                    checkedColor: Theme.of(context).colorScheme.primary,
                    uncheckedColor: Theme.of(context).colorScheme.secondary,
                  ),
                  style: MSHCheckboxStyle.fillScaleColor,
                ),
              ),
              SizedBox(
                width: SizeUtils.scale(AppSize().paddingS8, size.width),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: SizeUtils.scale(260, size.width),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: SizeUtils.scale(AppSize().paddingS4, size.width),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: AppSize().paddingS5),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: size.width * 0.56,
                      ),
                      child: MyText(
                        text: (task.name ?? "Task Name").capitalizeFirst,
                        maxLines: 2,
                        style: AppFonts().bodyLarge.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: SizeUtils.scale(AppSize().paddingS1, size.width),
                    ),
                    MyText(
                      text: task.endDate != null
                          ? "${"Due:".trString} ${DateUtil.formatMillisecondsToDOB(task.endDate!)}"
                          : "Due: N/A",
                      style: AppFonts().bodySmallRegular.copyWith(
                            color: task.endDate == null
                                ? Theme.of(context).colorScheme.secondary
                                : task.status == TaskStatus.completed
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: SizeUtils.scale(40, size.width),
                height: SizeUtils.scale(40, size.width),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Icon(
                  task.icon?.isEmpty == false || icon != null
                      ? IconData(task.icon!.toInt(),
                          fontFamily: 'MaterialIcons')
                      : Icons.task,
                  color: Colors.white,
                  size: SizeUtils.scale(
                    16,
                    size.width,
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
