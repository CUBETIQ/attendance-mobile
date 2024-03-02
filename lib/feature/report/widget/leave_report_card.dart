import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/admin_leave_report_model.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/string_util.dart';
import 'package:flutter/material.dart';

class LeaveReportCard extends StatelessWidget {
  const LeaveReportCard({
    super.key,
    required this.data,
  });

  final AdminLeaveReportModel data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ExpansionTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyCacheImage(imageUrl: data.image ?? ""),
          SizedBox(width: SizeUtils.scaleMobile(10, size.width)),
          SizedBox(
            width: SizeUtils.scaleMobile(110, size.width),
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
        vertical: SizeUtils.scaleMobile(
          5,
          MediaQuery.of(context).size.width,
        ),
        horizontal: SizeUtils.scaleMobile(
          10,
          MediaQuery.of(context).size.width,
        ),
      ),
      // children: [],
    );
  }
}
