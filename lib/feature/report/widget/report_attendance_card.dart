import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/text/text.dart';
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
      height: SizeUtils.scale(75, size.width),
      padding: EdgeInsets.only(
        right: SizeUtils.scale(20, size.width),
      ),
      borderRadius: BorderRadius.circular(
        SizeUtils.scale(
          14,
          size.width,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: SizeUtils.scale(35, size.width),
            height: SizeUtils.scale(75, size.width),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  SizeUtils.scale(
                    14,
                    size.width,
                  ),
                ),
                bottomLeft: Radius.circular(
                  SizeUtils.scale(
                    14,
                    size.width,
                  ),
                ),
              ),
              color: Colors.green,
            ),
          ),
          SizedBox(
            width: SizeUtils.scale(15, size.width),
          ),
          Expanded(
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
                      style: AppFonts().bodyMediumSemi,
                    ),
                    MyText(
                      text: "Check In",
                      style: AppFonts().bodySmallMedium.copyWith(
                            color: MyColor.successColor,
                          ),
                    ),
                    MyText(
                      text: "Check Out",
                      style: AppFonts().bodySmallMedium.copyWith(
                            color: MyColor.errorColor,
                          ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Time",
                      style: AppFonts().bodyMediumSemi,
                    ),
                    MyText(
                      text: DateUtil.formatTimeWithDate(
                        attendance.checkInDateTime,
                      ),
                      style: AppFonts().bodySmallRegular,
                    ),
                    MyText(
                      text: DateUtil.formatTimeWithDate(
                        attendance.checkOutDateTime,
                      ),
                      style: AppFonts().bodySmallRegular,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyText(
                      text: "Status",
                      style: AppFonts().bodyMediumSemi.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    SizedBox(height: SizeUtils.scale(2, size.width)),
                    MyText(
                      text:
                          attendance.checkInStatus.capitalizeMaybeNull ?? "N/A",
                      style: AppFonts().bodySmallRegular.copyWith(
                            color: attendance.checkInStatus != null
                                ? ColorUtil.getStatusColor(
                                    attendance.checkInStatus)
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    MyText(
                      text: attendance.checkOutStatus?.capitalizeMaybeNull ??
                          "N/A",
                      style: AppFonts().bodySmallRegular.copyWith(
                            color: attendance.checkOutStatus != null
                                ? ColorUtil.getStatusColor(
                                    attendance.checkOutStatus)
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
