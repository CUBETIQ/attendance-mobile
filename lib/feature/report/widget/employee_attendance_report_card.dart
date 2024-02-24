import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/admin_attendance_report_model.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/report/widget/attendance_data_row.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/utils/string_util.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:timesync360/types/attendance_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeAttendanceReportCard extends StatelessWidget {
  const EmployeeAttendanceReportCard({
    super.key,
    required this.data,
    required this.totalWorkMinute,
  });

  final AdminAttendanceReportModel data;
  final int? totalWorkMinute;

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
          Expanded(
            child: MyText(
              text: data.position ?? "N/A",
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
        AttendanceDataRowReport(
          title: "Check In: ",
          value: DateFormatter.formatTimeWithDate(
            data.attendance?.checkInDateTime,
          ),
        ),
        SizedBox(height: SizeUtils.scale(2, size.width)),
        AttendanceDataRowReport(
          title: "Check In Status: ",
          value: data.attendance.isBlank == false &&
                  data.attendance?.checkInStatus != null
              ? data.attendance?.checkInStatus!.capitalizeFirst
              : "N/A",
          textColor:
              data.attendance != null && data.attendance?.checkInStatus != null
                  ? data.attendance?.checkInStatus == AttendanceStatus.early
                      ? Colors.green
                      : data.attendance?.checkInStatus == AttendanceStatus.late
                          ? Colors.red
                          : Colors.orange
                  : Theme.of(context).colorScheme.onBackground,
        ),
        SizedBox(
          height: SizeUtils.scale(
            data.attendance != null ? 2 : 0,
            size.width,
          ),
        ),
        data.attendance != null && data.attendance?.checkInEarly != null
            ? AttendanceDataRowReport(
                title: "Check In Early: ",
                value: DateFormatter.getHourMinuteSecondFromMinute(
                  data.attendance?.checkInEarly,
                ),
              )
            : data.attendance != null && data.attendance?.checkInLate != null
                ? AttendanceDataRowReport(
                    title: "Check In Late: ",
                    value: DateFormatter.getHourMinuteSecondFromMinute(
                      data.attendance?.checkInLate,
                    ),
                  )
                : const SizedBox.shrink(),
        SizedBox(height: SizeUtils.scale(2, size.width)),
        AttendanceDataRowReport(
          title: "Check Out: ",
          value: DateFormatter.formatTimeWithDate(
            data.attendance?.checkOutDateTime,
          ),
        ),
        SizedBox(height: SizeUtils.scale(2, size.width)),
        AttendanceDataRowReport(
            title: "Check Out Status: ",
            value: data.attendance != null &&
                    data.attendance?.checkOutStatus != null
                ? data.attendance?.checkOutStatus!.capitalizeFirst
                : "N/A",
            textColor: data.attendance != null &&
                    data.attendance?.checkOutStatus != null
                ? data.attendance?.checkOutStatus == AttendanceStatus.early
                    ? Colors.green
                    : data.attendance?.checkOutStatus == AttendanceStatus.late
                        ? Colors.red
                        : Colors.orange
                : Theme.of(context).colorScheme.onBackground),
        SizedBox(
          height: SizeUtils.scale(data.attendance != null ? 2 : 0, size.width),
        ),
        data.attendance != null && data.attendance?.checkOutLate != null
            ? AttendanceDataRowReport(
                title: "Check Out Late: ",
                value: DateFormatter.getHourMinuteSecondFromMinute(
                  data.attendance?.checkOutLate,
                ),
              )
            : data.attendance != null && data.attendance?.checkOutEarly != null
                ? AttendanceDataRowReport(
                    title: "Check Out Early: ",
                    value: DateFormatter.getHourMinuteSecondFromMinute(
                      data.attendance?.checkOutEarly,
                    ),
                  )
                : const SizedBox.shrink(),
        SizedBox(height: SizeUtils.scale(2, size.width)),
        AttendanceDataRowReport(
          title: "Work Hour: ",
          value: DateFormatter.getHourMinuteSecondFromMinute(totalWorkMinute),
        ),
        SizedBox(height: SizeUtils.scale(2, size.width)),
        AttendanceDataRowReport(
          title: "Total Session ",
          value: (data.attendance?.totalSession ?? 0).toString(),
        ),
      ],
    );
  }
}
