import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/color.dart';
import 'package:timesync360/core/widgets/no_data/no_data.dart';
import 'package:timesync360/feature/home/summary_attendance/controller/index.dart';
import 'package:timesync360/feature/home/summary_attendance/widget/summary_detail_card.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AbsentTabMobile extends StatelessWidget {
  const AbsentTabMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = SummaryAttendanceController.to;
    return Obx(
      () => controller.absentUser.value.isEmpty
          ? const MyNoData()
          : SingleChildScrollView(
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
                        itemCount: controller.absentUser.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(
                          height: SizeUtils.scale(10, size.width),
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final staff = controller.absentUser[index];
                          return SummaryDetailCard(
                            staff: staff,
                            status: "Absent",
                            valueColor: MyColor.errorColor,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}