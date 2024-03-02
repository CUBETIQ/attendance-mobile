import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/user_model.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:timesync360/core/widgets/no_data/no_data.dart';
import 'package:timesync360/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/home/admin_leave_request/controller/index.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:timesync360/types/leave_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../core/widgets/async_widget/async_base_widget.dart';
import '../../widget/leave_request_card.dart';

class AdminLeaveRequestViewMobile extends StatelessWidget {
  const AdminLeaveRequestViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AdminLeaveRequestController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Leave Request",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: MyRefreshIndicator(
        onRefresh: controller.onRefresh,
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.scaleMobile(
                  AppSize().paddingHorizontalLarge,
                  MediaQuery.of(context).size.width,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeUtils.scaleMobile(
                        AppSize().paddingVerticalLarge, size.width),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                          text: "Employee Leave",
                          style: AppFonts().bodyXlargeMedium),
                      Obx(
                        () => DateDropDown(
                          date: controller.selectDate.value,
                          size: size,
                          isShowday: false,
                          onTap: () => controller.onTapDate(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeUtils.scaleMobile(20, size.width)),
                  Obx(
                    () => MyAsyncWidget(
                      isLoading: controller.isLoading.value,
                      list: controller.leaveList,
                      noDataWidget: MyNoData(
                        paddingTop: SizeUtils.scaleMobile(180, size.width),
                      ),
                      builderWidget: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                            height: SizeUtils.scaleMobile(10, size.width)),
                        itemCount: controller.leaveList.value.length,
                        itemBuilder: (context, index) {
                          final leave = controller.leaveList.value[index];
                          final staff = controller.staffList.firstWhere(
                              (element) => element.id == leave.userId,
                              orElse: () => UserModel());
                          return LeaveRequestCard(
                            leave: leave,
                            staff: staff,
                            onTapView: () => controller.onTapView(index),
                            onTapApprove: () => controller.changeLeaveStatus(
                              leave: leave,
                              status: LeaveStatus.approved,
                            ),
                            onTapDecline: () => controller.changeLeaveStatus(
                              leave: leave,
                              status: LeaveStatus.rejected,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
