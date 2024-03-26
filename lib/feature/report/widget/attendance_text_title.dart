import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';

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
              padding: EdgeInsets.only(bottom: SizeUtils.scale(12, size.width)),
              child: MyText(
                text: 'My Attendance',
                style: AppFonts.TitleMedium.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
    );
  }
}
