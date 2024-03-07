import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/types/attendance_status.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_size.dart';

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
      width: size.width - 10,
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.scaleMobile(
            AppSize().paddingHorizontalLarge - 2, size.width),
        vertical:
            SizeUtils.scaleMobile(AppSize().paddingVerticalMedium, size.width),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyCacheImage(
                imageUrl: staff.image ?? "",
                width: SizeUtils.scaleMobile(50, size.width),
                height: SizeUtils.scaleMobile(50, size.width),
              ),
              SizedBox(width: SizeUtils.scaleMobile(15, size.width)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: SizeUtils.scaleMobile(200, size.width),
                    ),
                    child: MyText(
                      text: StringUtil.getfullname(
                        staff.firstName,
                        staff.lastName,
                        staff.username,
                      ),
                      style: AppFonts().bodyLargeSemi,
                    ),
                  ),
                  MyText(
                    text: position.name ?? "N/A",
                    style: AppFonts().bodyMediumRegular,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: SizeUtils.scaleMobile(5, size.width)),
          const Divider(),
          SizedBox(height: SizeUtils.scaleMobile(5, size.width)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Attendance",
                    style: AppFonts().bodyMediumSemi,
                  ),
                  SizedBox(height: SizeUtils.scaleMobile(2, size.width)),
                  MyText(
                    text: "Check In",
                    style: AppFonts().bodySmallMedium,
                  ),
                  SizedBox(height: SizeUtils.scaleMobile(2, size.width)),
                  MyText(
                    text: "Check Out",
                    style: AppFonts().bodySmallMedium,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Time",
                    style: AppFonts().bodyMediumSemi,
                  ),
                  SizedBox(height: SizeUtils.scaleMobile(2, size.width)),
                  MyText(
                    text: DateUtil.formatTimeWithDate(
                      attendance.checkInDateTime,
                    ),
                    style: AppFonts().bodySmallRegular,
                  ),
                  SizedBox(height: SizeUtils.scaleMobile(2, size.width)),
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
                children: [
                  MyText(
                    text: "Status",
                    style: AppFonts().bodyMediumSemi,
                  ),
                  SizedBox(height: SizeUtils.scaleMobile(2, size.width)),
                  MyText(
                    text: attendance.checkInStatus.capitalizeMaybeNull ?? "N/A",
                    style: AppFonts().bodySmallRegular.copyWith(
                          color: attendance.checkInStatus != null
                              ? attendance.checkInStatus ==
                                      AttendanceStatus.early
                                  ? Colors.green
                                  : attendance.checkInStatus ==
                                          AttendanceStatus.late
                                      ? Colors.red
                                      : Colors.orange
                              : Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  SizedBox(height: SizeUtils.scaleMobile(2, size.width)),
                  MyText(
                    text:
                        attendance.checkOutStatus.capitalizeMaybeNull ?? "N/A",
                    style: AppFonts().bodySmallRegular.copyWith(
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
        ],
      ),
    );
  }
}
