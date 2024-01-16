import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/admin_attendance_report_model.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/report/widget/data_row.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_util.dart';
import 'package:attendance_app/utils/types_helper/attendance_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceReportCard extends StatelessWidget {
  const AttendanceReportCard({
    super.key,
    required this.data,
    this.checkInDateTime,
    this.checkOutDateTime,
    required this.totalWorkMinute,
  });

  final AdminReportModel data;
  final int? checkInDateTime;
  final int? checkOutDateTime;
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
              text: data.username ?? "",
              overflow: TextOverflow.ellipsis,
              style: BodyMediumMedium,
              maxLines: 2,
            ),
          ),
          Expanded(
            child: MyText(
              text: data.position ?? "N/A",
              overflow: TextOverflow.ellipsis,
              style: BodyMediumMedium,
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
        DataRowReport(
          title: "Check In: ",
          value: DateFormatter().formatTimeWithDate(checkInDateTime),
        ),
        SizedBox(height: SizeUtils.scale(2, size.width)),
        DataRowReport(
          title: "Check In Status: ",
          value: data.attendance?.isNotEmpty == true
              ? data.attendance?.first.checkInStatus!.capitalizeFirst
              : "N/A",
          textColor: data.attendance?.isNotEmpty == true &&
                  data.attendance?.first.checkInStatus != null
              ? data.attendance?.first.checkInStatus == AttendanceStatus.early
                  ? Colors.green
                  : data.attendance?.first.checkInStatus ==
                          AttendanceStatus.late
                      ? Colors.red
                      : Colors.orange
              : Theme.of(context).colorScheme.onBackground,
        ),
        SizedBox(
          height: SizeUtils.scale(
            data.attendance?.isNotEmpty == true ? 2 : 0,
            size.width,
          ),
        ),
        data.attendance?.isNotEmpty == true &&
                data.attendance?.first.checkInEarly != null
            ? DataRowReport(
                title: "Check In Early: ",
                value: DateFormatter().getHourMinuteSecondFromMinute(
                  data.attendance?.first.checkInEarly,
                ),
              )
            : data.attendance?.isNotEmpty == true &&
                    data.attendance?.first.checkInLate != null
                ? DataRowReport(
                    title: "Check In Late: ",
                    value: DateFormatter().getHourMinuteSecondFromMinute(
                      data.attendance?.first.checkInLate,
                    ),
                  )
                : const SizedBox.shrink(),
        SizedBox(height: SizeUtils.scale(2, size.width)),
        DataRowReport(
          title: "Check Out: ",
          value: DateFormatter().formatTimeWithDate(checkOutDateTime),
        ),
        SizedBox(height: SizeUtils.scale(2, size.width)),
        DataRowReport(
          title: "Check Out Status: ",
          value: data.attendance?.isNotEmpty == true
              ? (data.attendance?.length ?? 0) > 1
                  ? data.attendance?.last.checkOutStatus!.capitalizeFirst
                  : data.attendance?.first.checkOutStatus!.capitalizeFirst
              : "N/A",
          textColor: data.attendance?.isNotEmpty == true &&
                  (data.attendance?.length ?? 0) > 1
              ? data.attendance?.last.checkOutStatus != null
                  ? data.attendance?.last.checkOutStatus ==
                          AttendanceStatus.early
                      ? Colors.green
                      : data.attendance?.last.checkOutStatus ==
                              AttendanceStatus.late
                          ? Colors.red
                          : Colors.orange
                  : Theme.of(context).colorScheme.onBackground
              : data.attendance?.isNotEmpty == true &&
                      (data.attendance?.length ?? 0) <= 1
                  ? data.attendance?.first.checkOutStatus != null
                      ? data.attendance?.first.checkOutStatus ==
                              AttendanceStatus.early
                          ? Colors.green
                          : data.attendance?.first.checkOutStatus ==
                                  AttendanceStatus.late
                              ? Colors.red
                              : Colors.orange
                      : Theme.of(context).colorScheme.onBackground
                  : Theme.of(context).colorScheme.onBackground,
        ),
        SizedBox(
            height: SizeUtils.scale(
                data.attendance?.isNotEmpty == true ? 2 : 0, size.width)),
        data.attendance?.isNotEmpty == true &&
                (data.attendance?.length ?? 0) > 1
            ? data.attendance?.last.checkOutEarly != null
                ? DataRowReport(
                    title: "Check Out Early: ",
                    value: DateFormatter().getHourMinuteSecondFromMinute(
                      data.attendance?.last.checkOutEarly,
                    ),
                  )
                : data.attendance?.last.checkOutLate != null
                    ? DataRowReport(
                        title: "Check Out Late: ",
                        value: DateFormatter().getHourMinuteSecondFromMinute(
                          data.attendance?.last.checkOutLate,
                        ),
                      )
                    : const SizedBox.shrink()
            : data.attendance?.isNotEmpty == true &&
                    (data.attendance?.length ?? 0) <= 1
                ? data.attendance?.first.checkOutEarly != null
                    ? DataRowReport(
                        title: "Check Out Early: ",
                        value: DateFormatter().getHourMinuteSecondFromMinute(
                          data.attendance?.first.checkOutEarly,
                        ),
                      )
                    : data.attendance?.first.checkOutLate != null
                        ? DataRowReport(
                            title: "Check Out Late: ",
                            value:
                                DateFormatter().getHourMinuteSecondFromMinute(
                              data.attendance?.first.checkOutLate,
                            ),
                          )
                        : const SizedBox.shrink()
                : const SizedBox.shrink(),
        SizedBox(height: SizeUtils.scale(2, size.width)),
        DataRowReport(
          title: "Work Hour: ",
          value: DateFormatter().getHourMinuteSecondFromMinute(totalWorkMinute),
        ),
      ],
    );
  }
}
