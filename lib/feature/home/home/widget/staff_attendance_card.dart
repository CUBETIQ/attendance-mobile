import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/card/my_card.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/color_utils.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

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
        horizontal:
            SizeUtils.scale(AppSize().paddingHorizontalLarge - 2, size.width),
        vertical: SizeUtils.scale(AppSize().paddingVerticalMedium, size.width),
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
                    style: AppFonts().bodyMediumSemi,
                  ),
                  SizedBox(height: SizeUtils.scale(2, size.width)),
                  MyText(
                    text: "Check In",
                    style: AppFonts().bodySmallMedium,
                  ),
                  SizedBox(height: SizeUtils.scale(2, size.width)),
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
                  SizedBox(height: SizeUtils.scale(2, size.width)),
                  MyText(
                    text: DateUtil.formatTimeWithDate(
                      attendance.checkInDateTime,
                    ),
                    style: AppFonts().bodySmallRegular,
                  ),
                  SizedBox(height: SizeUtils.scale(2, size.width)),
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
                  SizedBox(height: SizeUtils.scale(2, size.width)),
                  MyText(
                    text: attendance.checkInStatus.capitalizeMaybeNull ?? "N/A",
                    style: AppFonts().bodySmallRegular.copyWith(
                          color: attendance.checkInStatus != null
                              ? ColorUtil.getStatusColor(
                                  attendance.checkInStatus)
                              : Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  SizedBox(height: SizeUtils.scale(2, size.width)),
                  MyText(
                    text:
                        attendance.checkOutStatus.capitalizeMaybeNull ?? "N/A",
                    style: AppFonts().bodySmallRegular.copyWith(
                          color: attendance.checkOutStatus != null
                              ? ColorUtil.getStatusColor(
                                  attendance.checkOutStatus!, isCheckOut: true)
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
