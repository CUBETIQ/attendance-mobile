import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/card/my_card.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import '../../../../config/app_size.dart';

class StaffAttendanceCard extends StatelessWidget {
  const StaffAttendanceCard({
    super.key,
    required this.staff,
    required this.attendance,
  });

  final UserModel staff;
  final AttendanceModel attendance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyCard(
        width: size.width - 10,
        height: SizeUtils.scale(80, size.width),
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
          ),
          vertical: SizeUtils.scale(
            AppSize.paddingVerticalMedium,
            size.width,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${staff.firstName} ${staff.lastName}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    staff.gender ?? "Other",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attendance.checkInDateTime.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  attendance.checkOutDateTime.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
