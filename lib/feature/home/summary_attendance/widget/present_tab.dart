import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/color.dart';
import 'package:timesync/core/widgets/no_data/no_data.dart';
import 'package:timesync/feature/home/summary_attendance/controller/index.dart';
import 'package:timesync/feature/home/summary_attendance/widget/summary_detail_card.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class PresentTab extends StatelessWidget {
  const PresentTab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = SummaryAttendanceController.to;
    return Obx(
      () => controller.staffAttendanceList.isEmpty
          ? const MyNoData()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.scale(
                    AppSize().paddingHorizontalLarge,
                    size.width,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeUtils.scale(30, size.width)),
                    Obx(
                      () => ListView.separated(
                        itemCount: controller.staffAttendanceList.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(
                          height: SizeUtils.scale(10, size.width),
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final staff = controller.getStaffForAttendance(
                            controller.staffAttendanceList[index],
                          );
                          return SummaryDetailCard(
                            staff: staff,
                            status: "Present",
                            valueColor: MyColor.successColor,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: SizeUtils.scale(10, size.width)),
                  ],
                ),
              ),
            ),
    );
  }
}
