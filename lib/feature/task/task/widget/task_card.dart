import 'package:flutter/material.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/task_model.dart';
import 'package:timesync/core/widgets/check_box/check_box.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';

import '../../../../types/task.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final void Function()? onTap;
  final void Function() onCheck;
  final String? icon;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    required this.onCheck,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize().borderRadiusLarge),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            ),
            color: Theme.of(context).colorScheme.background),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.scale(16, size.width),
              vertical: SizeUtils.scale(12, size.width)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: task.name ?? "",
                      maxLines: 2,
                      style: AppFonts.TitleSmall.copyWith(
                        decoration: task.status == TaskStatus.done
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: SizeUtils.scale(8, size.width)),
                      child: MyText(
                        text: task.endDate != null
                            ? DateUtil.formatMillisecondsToDOB(task.endDate!)
                            : "N/A",
                        style: AppFonts.LabelSmall.copyWith(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: SizeUtils.scale(12, size.width)),
                child: IgnorePointer(
                  ignoring: task.status == TaskStatus.done ? true : false,
                  child: MyCheckBox(
                    hasNoBackground: true,
                    isChecked: task.status == TaskStatus.done ? true : false,
                    onTap: onCheck,
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
