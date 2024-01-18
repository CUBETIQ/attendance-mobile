import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/color.dart';
import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/widgets/card/my_card.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/time_util.dart';
import 'package:attendance_app/utils/types_helper/attendance_status.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Attendance",
                      style: BodyMediumSemi,
                    ),
                    SizedBox(height: SizeUtils.scale(2, size.width)),
                    MyText(
                      text: "Check In",
                      style: BodySmallMedium.copyWith(
                        color: MyColor.successColor,
                      ),
                    ),
                    SizedBox(height: SizeUtils.scale(2, size.width)),
                    MyText(
                      text: "Check Out",
                      style: BodySmallMedium.copyWith(
                        color: MyColor.errorColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Time",
                      style: BodyMediumSemi,
                    ),
                    SizedBox(height: SizeUtils.scale(2, size.width)),
                    MyText(
                      text: DateFormatter().formatTimeWithDate(
                        attendance.checkInDateTime,
                      ),
                      style: BodySmallRegular,
                    ),
                    SizedBox(height: SizeUtils.scale(2, size.width)),
                    MyText(
                      text: DateFormatter().formatTimeWithDate(
                        attendance.checkOutDateTime,
                      ),
                      style: BodySmallRegular,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: "Status",
                      style: BodyMediumSemi.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: SizeUtils.scale(2, size.width)),
                    MyText(
                      text:
                          attendance.checkInStatus.capitalizeMaybeNull ?? "N/A",
                      style: BodySmallRegular.copyWith(
                        color: attendance.checkInStatus != null
                            ? attendance.checkInStatus == AttendanceStatus.early
                                ? Colors.green
                                : attendance.checkInStatus ==
                                        AttendanceStatus.late
                                    ? Colors.red
                                    : Colors.orange
                            : Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    SizedBox(height: SizeUtils.scale(2, size.width)),
                    MyText(
                      text: attendance.checkOutStatus?.capitalizeMaybeNull ??
                          "N/A",
                      style: BodySmallRegular.copyWith(
                        color: attendance.checkOutStatus != null
                            ? attendance.checkOutStatus ==
                                    AttendanceStatus.early
                                ? Colors.green
                                : attendance.checkOutStatus ==
                                        AttendanceStatus.late
                                    ? Colors.red
                                    : Colors.orange
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
