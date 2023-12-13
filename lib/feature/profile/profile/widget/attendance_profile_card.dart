import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:flutter/material.dart';

class AttendanceProfileCard extends StatelessWidget {
  final Size size;
  final String? totalLeave;
  final String? totalAbsent;
  final String? totalAttendance;

  const AttendanceProfileCard({
    super.key,
    required this.size,
    this.totalLeave,
    this.totalAbsent,
    this.totalAttendance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width * 0.25,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.borderRadiusLarge * (size.width / 375),
        ),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.065),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: "Attendance",
                    style: BodySmallRegular,
                  ),
                  SizedBox(height: size.height * 0.01),
                  MyText(
                    text: totalAttendance ?? "0",
                    style: BodyXlargeMedium,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: "Absent",
                    style: BodySmallRegular,
                  ),
                  SizedBox(height: size.height * 0.01),
                  MyText(
                    text: totalAbsent ?? "0",
                    style: BodyXlargeMedium,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: "On Leave",
                    style: BodySmallRegular,
                  ),
                  SizedBox(height: size.height * 0.01),
                  MyText(
                    text: totalLeave ?? "0",
                    style: BodyXlargeMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
