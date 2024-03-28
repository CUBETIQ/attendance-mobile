import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/utils/color_utils.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';

class ReportAttendanceCard extends StatelessWidget {
  const ReportAttendanceCard({super.key, required this.attendance});

  final AttendanceModel attendance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyCard(
      width: size.width,
      padding: EdgeInsets.symmetric(
        vertical: SizeUtils.scale(12, size.width),
        horizontal: SizeUtils.scale(16, size.width),
      ),
      boxShadow: const [],
      border: Border.all(color: Theme.of(context).colorScheme.primary),
      borderRadius:
          BorderRadius.circular(SizeUtils.scale(AppSpacing.L, size.width)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: "Attendance",
                style: AppFonts.TitleXSmall.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              MyText(
                text: "Check-in",
                style: AppFonts.LabelSmall.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              MyText(
                text: "Check-out",
                style: AppFonts.LabelSmall.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ].withDivide(height: SizeUtils.scale(4, size.width)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: "Time",
                style: AppFonts.TitleXSmall.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              MyText(
                text: DateUtil.formatTimeWithDate(
                  attendance.checkInDateTime,
                ),
                style: AppFonts.LabelSmall.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              MyText(
                text: DateUtil.formatTimeWithDate(
                  attendance.checkOutDateTime,
                ),
                style: AppFonts.LabelSmall.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ].withDivide(height: SizeUtils.scale(4, size.width)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyText(
                text: "Status",
                style: AppFonts.TitleXSmall.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              MyText(
                text: attendance.checkInStatus.capitalizeMaybeNull ?? "-",
                style: AppFonts.LabelSmall.copyWith(
                  color: attendance.checkInStatus != null
                      ? ColorUtil.getStatusColor(
                          context, attendance.checkInStatus)
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
              MyText(
                text: attendance.checkOutStatus?.capitalizeMaybeNull ?? "-",
                style: AppFonts.LabelSmall.copyWith(
                  color: attendance.checkOutStatus != null
                      ? ColorUtil.getStatusColor(
                          context, attendance.checkOutStatus,
                          isCheckOut: true)
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ].withDivide(height: SizeUtils.scale(4, size.width)),
          ),
        ],
      ),
    );
  }
}
