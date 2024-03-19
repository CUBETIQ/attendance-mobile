import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/core/model/admin_task_report_model.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/types/task_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskDataRowReport extends StatelessWidget {
  const TaskDataRowReport({
    super.key,
    this.data,
  });

  final TaskReportModel? data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: SizeUtils.scale(30, size.width),
              height: SizeUtils.scale(30, size.width),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data?.color != null
                    ? Color(data!.color!.toInt())
                    : Theme.of(context).colorScheme.primary,
              ),
              child: Icon(
                data?.icon?.isEmpty == false || data?.icon != null
                    ? IconData(data!.icon!.toInt(), fontFamily: 'MaterialIcons')
                    : Icons.task,
                color: Colors.white,
                size: SizeUtils.scale(18, size.width),
              ),
            ),
            SizedBox(width: SizeUtils.scale(10, size.width)),
            Container(
              constraints: BoxConstraints(
                maxWidth: SizeUtils.scale(255, size.width),
              ),
              child: MyText(
                text: data?.name?.capitalizeFirst ?? "",
                overflow: TextOverflow.ellipsis,
                style: AppFonts().bodyMediumMedium,
                maxLines: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: SizeUtils.scale(5, size.width)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MyText(
                  text: "Status: ",
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts().bodySmallRegular.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                MyText(
                  text: data?.status?.capitalizeFirst ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts().bodySmallRegular.copyWith(
                        color: data?.status == TaskStatus.done
                            ? MyColor.successColor
                            : MyColor.pendingColor,
                      ),
                ),
              ],
            ),
            Row(
              children: [
                MyText(
                  text: "Due Date: ",
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts().bodySmallRegular.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                MyText(
                  text: DateUtil.formatMillisecondsToDOB(data?.endDate),
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts().bodySmallRegular.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: SizeUtils.scale(10, size.width)),
      ],
    );
  }
}
