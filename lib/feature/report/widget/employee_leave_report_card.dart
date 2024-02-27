import 'package:flutter/material.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/admin_leave_report_model.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/report/widget/leave_data_row.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/string_util.dart';

class EmployeeLeaveReportCard extends StatelessWidget {
  const EmployeeLeaveReportCard({super.key, required this.data});

  final AdminLeaveReportModel data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ExpansionTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyCacheImage(imageUrl: data.image ?? ""),
          SizedBox(width: SizeUtils.scale(10, size.width)),
          SizedBox(
            width: SizeUtils.scale(110, size.width),
            child: MyText(
              text: StringUtil.getfullname(
                  data.firstName, data.lastName, data.username),
              overflow: TextOverflow.ellipsis,
              style: AppStyles().bodyMediumMedium,
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
      children: [
        data.leave?.type != null
            ? LeaveDataRowReport(
                leave: data.leave,
              )
            : Padding(
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
                        text: "Not On Leave",
                        style: AppStyles().bodyMediumMedium,
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
