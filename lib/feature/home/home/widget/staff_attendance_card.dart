import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/card/my_card.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/string_util.dart';
import 'package:attendance_app/utils/time_util.dart';
import 'package:attendance_app/utils/types_helper/attendance_status.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import '../../../../config/app_size.dart';

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
        horizontal:
            SizeUtils.scale(AppSize.paddingHorizontalLarge - 2, size.width),
        vertical: SizeUtils.scale(AppSize.paddingVerticalMedium, size.width),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyCacheImage(
                imageUrl: staff.image ?? "",
                width: SizeUtils.scale(50, size.width),
                height: SizeUtils.scale(50, size.width),
              ),
              SizedBox(width: SizeUtils.scale(15, size.width)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: SizeUtils.scale(200, size.width),
                    ),
                    child: MyText(
                      text: StringUtil().getfullname(
                        staff.firstName,
                        staff.lastName,
                        staff.username,
                      ),
                      style: BodyLargeSemi,
                    ),
                  ),
                  MyText(
                    text: position.name ?? "N/A",
                    style: BodyMediumRegular,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: SizeUtils.scale(5, size.width)),
          const Divider(),
          SizedBox(height: SizeUtils.scale(5, size.width)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Attendance",
                    style: BodyMediumSemi,
                  ),
                  SizedBox(height: SizeUtils.scale(2, size.width)),
                  MyText(
                    text: "Check In",
                    style: BodySmallMedium,
                  ),
                  SizedBox(height: SizeUtils.scale(2, size.width)),
                  MyText(
                    text: "Check Out",
                    style: BodySmallMedium,
                  ),
                ],
              ),
              Column(
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
                children: [
                  MyText(
                    text: "Status",
                    style: BodyMediumSemi,
                  ),
                  SizedBox(height: SizeUtils.scale(2, size.width)),
                  MyText(
                    text: attendance.checkInStatus.capitalizeMaybeNull ?? "N/A",
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
                    text:
                        attendance.checkOutStatus.capitalizeMaybeNull ?? "N/A",
                    style: BodySmallRegular.copyWith(
                      color: attendance.checkOutStatus != null
                          ? attendance.checkOutStatus == AttendanceStatus.early
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
