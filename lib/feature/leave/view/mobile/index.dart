import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/async_widget/async_base_widget.dart';
import 'package:attendance_app/core/widgets/no_data/no_data.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/leave/controller/index.dart';
import 'package:attendance_app/feature/leave/widget/leave_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveViewMobile extends StatelessWidget {
  const LeaveViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LeaveController.to;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSize.paddingHorizontalLarge,
          right: AppSize.paddingHorizontalLarge,
          top: AppSize.paddingVerticalLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MyText(
                  text: "My Request",
                  style: BodyLargeMedium,
                ),
              ],
            ),
            const SizedBox(height: AppSize.paddingS10),
            Obx(
              () => MyAsyncWidget(
                isLoading: controller.isLoading.value,
                list: controller.leave,
                noDataWidget: const MyNoData(),
                builderWidget: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.leave.length,
                  itemBuilder: (context, index) {
                    return LeaveCard(
                      leave: controller.leave[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
