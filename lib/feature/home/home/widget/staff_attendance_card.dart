import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
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
import 'package:timesync/utils/color_utils.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

class StaffAttendanceCard extends StatelessWidget {
  const StaffAttendanceCard({
    super.key,
    required this.staff,
    required this.attendance,
    required this.position,
  });

  final UserModel staff;
  final AttendanceModel attendance;
  final PositionModel position;

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
                        text: position.name ?? "N/A",
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Attendance",
                      style: AppFonts.TitleXSmall,
                    ),
                    MyText(
                      text: "Check-in",
                      style: AppFonts.LabelSmall,
                    ),
                    MyText(
                      text: "Check-out",
                      style: AppFonts.LabelSmall,
                    ),
                  ].withSpaceBetween(height: SizeUtils.scale(4, size.width)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Time",
                      style: AppFonts.TitleXSmall,
                    ),
                    MyText(
                      text: DateUtil.formatTimeWithDate(
                        attendance.checkInDateTime,
                      ),
                      style: AppFonts.LabelSmall,
                    ),
                    MyText(
                      text: DateUtil.formatTimeWithDate(
                        attendance.checkOutDateTime,
                      ),
                      style: AppFonts.LabelSmall,
                    ),
                  ].withSpaceBetween(height: SizeUtils.scale(4, size.width)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Status",
                      style: AppFonts.TitleXSmall,
                    ),
                    MyText(
                      text:
                          attendance.checkInStatus.capitalizeMaybeNull ?? "N/A",
                      style: AppFonts.LabelSmall.copyWith(
                        color: attendance.checkInStatus != null
                            ? ColorUtil.getStatusColor(
                                context, attendance.checkInStatus)
                            : Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    MyText(
                      text: attendance.checkOutStatus.capitalizeMaybeNull ??
                          "N/A",
                      style: AppFonts.LabelSmall.copyWith(
                        color: attendance.checkOutStatus != null
                            ? ColorUtil.getStatusColor(
                                context, attendance.checkOutStatus!,
                                isCheckOut: true)
                            : Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ].withSpaceBetween(height: SizeUtils.scale(4, size.width)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
