import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/constants/color.dart';
import 'package:attendance_app/feature/home/summary_attendance/controller/index.dart';
import 'package:attendance_app/feature/home/summary_attendance/widget/summary_detail_card.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class LeaveTabMobile extends StatelessWidget {
  const LeaveTabMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = SummaryAttendanceController.to;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.scale(
            AppSize.paddingHorizontalLarge,
            size.width,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeUtils.scale(30, size.width)),
            Obx(
              () => ListView.separated(
                itemCount: controller.leaves.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                  height: SizeUtils.scale(10, size.width),
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final staff =
                      controller.getStaffForLeave(controller.leaves[index]);
                  return SummaryDetailCard(
                    staff: staff,
                    status: "On Leave",
                    valueColor: MyColor.pendingColor,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
