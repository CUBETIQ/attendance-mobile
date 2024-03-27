import 'package:flutter/material.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/feature/home/home/widget/record_data_card.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/types/attendance.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

class RecordCard extends StatelessWidget {
  final AttendanceModel? data;
  final double? width;
  final double? height;
  final DateTime date;
  final bool? isBreakTime;
  final String? breakTimeTitle;
  final int? startBreakTime;
  final int? endBreakTime;

  const RecordCard({
    super.key,
    this.width,
    this.height,
    required this.date,
    this.data,
    this.isBreakTime,
    this.breakTimeTitle,
    this.startBreakTime,
    this.endBreakTime,
  });

  @override
  Widget build(BuildContext context) {
    // Data
    final size = MediaQuery.of(context).size;
    final endBreakStatus = StringUtil.getStatusByCalculateBreakTime(
        endBreakTime,
        NavigationController.to.organization.value.configs?.breakTime
            ?.split("-")[1]
            .trim());
    final startBreak = NavigationController
            .to.organization.value.configs?.breakTime
            ?.split("-")[0]
            .trim() ??
        "00:00";
    final endBreak = NavigationController
            .to.organization.value.configs?.breakTime
            ?.split("-")[1]
            .trim() ??
        "00:00";

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeUtils.scale(AppSize().borderRadiusMedium, size.width),
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeUtils.scale(16, size.width)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: SizeUtils.scale(10, size.width)),
              child: MyText(
                text: DateUtil.formatFullDate(date),
                style: AppFonts.LabelMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Column(
              children: [
                RecordDataCard(
                  time: data?.checkInDateTime,
                  timeString:
                      "${NavigationController.to.organization.value.configs?.startHour ?? "00:00"} AM",
                  svgIcon: IconAssets.loginTwoTone,
                  statusTitle: "Check-In",
                  onNullTitle: "Check-in Schedule",
                  secondTitle: "Checked-in",
                  status: data?.checkInStatus,
                  statusLabel: StringUtil.calculateDurationWithStatus(
                      data?.checkInStatus == AttendanceStatus.late
                          ? (data?.checkInLate ?? 1)
                          : data?.checkInStatus == AttendanceStatus.early
                              ? (data?.checkInEarly ?? 1)
                              : 0,
                      data?.checkInStatus),
                  iconColor: const Color(0xFF198754),
                ),
                RecordDataCard(
                  time: startBreakTime,
                  timeString: DateUtil.formatTimeTo12Hour(
                    startBreak,
                    forceShowPM: true,
                  ),
                  svgIcon: IconAssets.noodle,
                  statusTitle: "Lunch Break",
                  onNullTitle: "Lunch Break",
                  secondTitle: "Lunch Break",
                  breakTimeTitle: endBreakTime != null ? "Finished" : "Ongoing",
                  isBreakTime: isBreakTime,
                  iconColor: Colors.white,
                  status: null,
                ),
                RecordDataCard(
                  time: endBreakTime,
                  timeString: DateUtil.formatTimeTo12Hour(endBreak),
                  svgIcon: IconAssets.charger,
                  statusTitle: "After Break",
                  onNullTitle: "After Break",
                  secondTitle: "After Break",
                  status: endBreakStatus,
                  statusLabel: StringUtil.calculationDurationForBreakTime(
                    endBreakTime,
                    endBreak,
                    endBreakStatus,
                  ),
                ),
                RecordDataCard(
                  time: data?.checkOutDateTime,
                  timeString:
                      "${NavigationController.to.organization.value.configs?.endHour ?? "00:00"} PM",
                  svgIcon: IconAssets.logoutTwoTone,
                  statusTitle: "Check-Out",
                  onNullTitle: "Check-out Schedule",
                  secondTitle: "Checked-out",
                  iconColor: Theme.of(context).colorScheme.error,
                  status: data?.checkOutStatus,
                  statusLabel: StringUtil.calculateDurationWithStatus(
                      data?.checkOutStatus == AttendanceStatus.late
                          ? (data?.checkOutLate ?? 1)
                          : data?.checkOutStatus == AttendanceStatus.early
                              ? (data?.checkOutEarly ?? 1)
                              : 0,
                      data?.checkOutStatus),
                  isCheckOut: true,
                ),
              ].withSpaceBetween(height: SizeUtils.scale(10, size.width)),
            ),
          ],
        ),
      ),
    );
  }
}
