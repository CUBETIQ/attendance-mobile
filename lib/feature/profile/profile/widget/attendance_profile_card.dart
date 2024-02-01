import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';

class AttendanceProfileCard extends StatelessWidget {
  final Size size;
  final int? totalLeave;
  final int? totalAbsent;
  final int? totalAttendance;

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
          SizeUtils.scale(AppSize.borderRadiusLarge, size.width),
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
                    text: "Present",
                    style: BodySmallRegular,
                  ),
                  SizedBox(height: size.height * 0.01),
                  MyText(
                    text: totalAttendance != null
                        ? totalAttendance.toString()
                        : "0",
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
                    text: totalAbsent != null ? totalAbsent.toString() : "0",
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
                    text: totalLeave != null ? totalLeave.toString() : "0",
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
