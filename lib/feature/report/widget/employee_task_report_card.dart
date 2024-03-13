import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/admin_task_report_model.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/report/widget/task_data_row.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';
import 'package:flutter/material.dart';

class EmployeeTaskReportCard extends StatelessWidget {
  const EmployeeTaskReportCard({
    super.key,
    required this.data,
  });

  final AdminTaskReportModel data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ExpansionTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyCacheImage(
            imageUrl: data.image ?? "",
            width: SizeUtils.scale(50, size.width),
            height: SizeUtils.scale(50, size.width),
            imageHeight: SizeUtils.scale(50, size.width),
            imageWidth: SizeUtils.scale(50, size.width),
          ),
          SizedBox(width: SizeUtils.scale(10, size.width)),
          SizedBox(
            width: SizeUtils.scale(110, size.width),
            child: MyText(
              text: StringUtil.getfullname(
                  data.firstName, data.lastName, data.username),
              overflow: TextOverflow.ellipsis,
              style: AppFonts().bodyMediumMedium,
              maxLines: 2,
            ),
          ),
        ],
      ),
      initiallyExpanded: true,
      expandedAlignment: Alignment.centerLeft,
      childrenPadding: EdgeInsets.symmetric(
        vertical: SizeUtils.scale(
          5,
          MediaQuery.of(context).size.width,
        ),
        horizontal: SizeUtils.scale(
          10,
          MediaQuery.of(context).size.width,
        ),
      ),
      children: data.task?.isNotEmpty == true
          ? [
              ...List.generate(
                data.task?.length ?? 0,
                (index) => TaskDataRowReport(
                  data: data.task?[index],
                ),
              ),
            ]
          : [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeUtils.scale(10, size.width),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: SizeUtils.scale(5, size.width)),
                      MyText(
                        text: "No Task",
                        style: AppFonts().bodyMediumMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
    );
  }
}
