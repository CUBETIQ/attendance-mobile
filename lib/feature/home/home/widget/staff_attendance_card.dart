import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_shadow.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/divider/dividers.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/utils/color_utils.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

class StaffAttendanceCard extends StatelessWidget {
  const StaffAttendanceCard({
    super.key,
    required this.staff,
    required this.attendance,
    this.position,
  });

  final UserModel staff;
  final List<AttendanceModel> attendance;
  final PositionModel? position;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyCard(
      backgroundColor: Theme.of(context).colorScheme.background,
      boxShadow: [AppShadow.shadowWithoutColor],
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.scale(16.5, size.width),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: SizeUtils.scale(12, size.width)),
            child: Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: SizeUtils.scale(16, size.width)),
                  child: MyCacheImage(
                    imageUrl: staff.image ?? "",
                    width: SizeUtils.scale(40, size.width),
                    height: SizeUtils.scale(40, size.width),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeUtils.scale(4, size.width)),
                        child: MyText(
                          text: StringUtil.getfullname(
                            staff.firstName,
                            staff.lastName,
                            staff.username,
                          ),
                          style: AppFonts.TitleSmall,
                        ),
                      ),
                      MyText(
                        text: position?.name ?? "-",
                        style: AppFonts.LabelSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const MyDivider(opacity: 0.25),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: SizeUtils.scale(12, size.width)),
            child: Column(
              children: [
                buildAttendanceLogRow(
                  context,
                  label: 'Check in',
                  value: DateUtil.formatTimeWithDate(
                    attendance.first.checkInDateTime,
                  ),
                  color: attendance.first.checkInStatus != null
                      ? ColorUtil.getStatusColor(
                          context, attendance.first.checkInStatus)
                      : Theme.of(context).colorScheme.onBackground,
                ),
                buildAttendanceLogRow(
                  context,
                  label: 'Check out',
                  value: DateUtil.formatTimeWithDate(
                    attendance.length > 1
                        ? attendance.lastOrNull?.checkOutDateTime
                        : attendance.firstOrNull?.checkOutDateTime,
                  ),
                  color: attendance.length > 1
                      ? attendance.lastOrNull?.checkOutDateTime != null
                          ? ColorUtil.getStatusColor(
                              context, attendance.lastOrNull?.checkOutStatus)
                          : Theme.of(context).colorScheme.onBackground
                      : attendance.firstOrNull?.checkOutDateTime != null
                          ? ColorUtil.getStatusColor(
                              context, attendance.firstOrNull?.checkOutStatus)
                          : Theme.of(context).colorScheme.onBackground,
                ),
                buildAttendanceLogRow(
                  context,
                  label: 'Hours worked',
                  value: DateUtil.getHourMinuteSecondFromMinute(
                    attendance.length > 1
                        ? attendance.lastOrNull?.duration
                        : attendance.firstOrNull?.duration,
                  ),
                ),
                buildAttendanceLogRow(
                  context,
                  label: 'Total Session',
                  value: attendance.length > 1 ? '${attendance.length}' : '1',
                ),
              ].withSpaceBetween(height: SizeUtils.scale(4, size.width)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAttendanceLogRow(BuildContext context,
      {String? label, String? value, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          text: '${label?.trString ?? ""}:',
          style: AppFonts.LabelSmall,
        ),
        MyText(
          text: value?.trString ?? "",
          style: AppFonts.LabelSmall.copyWith(
            color: color ?? Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}
