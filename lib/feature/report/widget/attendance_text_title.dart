import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/attendance_model.dart';
import 'package:timesync360/core/model/leave_model.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceTextTitle extends StatelessWidget {
  const AttendanceTextTitle(
      {super.key, required this.attendanceList, required this.leaves});

  final RxList<AttendanceModel> attendanceList;
  final RxList<LeaveModel> leaves;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => attendanceList.value.isEmpty && leaves.value.isNotEmpty
          ? const SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.only(
                left: SizeUtils.scale(
                  AppSize().paddingHorizontalLarge,
                  size.width,
                ),
                top: SizeUtils.scale(10, size.width),
                bottom: SizeUtils.scale(10, size.width),
              ),
              child: MyText(
                text: 'My Attendance',
                style: BodyLargeMedium.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
    );
  }
}
