import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/core/widgets/async_widget/async_base_widget.dart';
import 'package:attendance_app/core/widgets/no_data/no_data.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/leave/controller/index.dart';
import 'package:attendance_app/utils/types_helper/leave_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveViewMobile extends StatelessWidget {
  const LeaveViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LeaveController.to;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.paddingHorizontalLarge,
        ),
        child: Column(
          children: [
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
                    final item = controller.leave[index];
                    return Container(
                      height: 170 * (size.width / 375),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.paddingHorizontalLarge *
                            (size.width / 375.0),
                        vertical:
                            AppSize.paddingVerticalLarge * (size.width / 375.0),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSize.borderRadiusMedium * (size.width / 375.0),
                        ),
                        color: Theme.of(context).colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 20 * (size.width / 375.0),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSize.paddingHorizontalSmall *
                                      (size.width / 375.0),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(
                                    10 * (size.width / 375.0),
                                  ),
                                ),
                                child: MyText(
                                  text: "Pending",
                                ),
                              ),
                              MyText(
                                text:
                                    "${item.leaveType ?? LeaveType.annual} leave request",
                              ),
                            ],
                          )
                        ],
                      ),
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
