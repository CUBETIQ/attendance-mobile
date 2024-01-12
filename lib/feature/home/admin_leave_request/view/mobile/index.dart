import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:attendance_app/core/widgets/no_data/no_data.dart';
import 'package:attendance_app/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/home/admin_leave_request/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/types_helper/leave_status.dart';
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SizeUtils.scale(15, size.width)),
            child: Icon(
              Icons.filter_list,
              color: Theme.of(context).colorScheme.onBackground,
              size: 25 * (size.width / 375.0),
            ),
          ),
        ],
      ),
      body: MyRefreshIndicator(
        onRefresh: controller.onRefresh,
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.scale(
                  AppSize.paddingHorizontalLarge,
                  MediaQuery.of(context).size.width,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeUtils.scale(
                        AppSize.paddingVerticalLarge, size.width),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(text: "Employee Leave", style: BodyXlargeMedium),
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
                  SizedBox(height: SizeUtils.scale(20, size.width)),
                  Obx(
                    () => MyAsyncWidget(
                      isLoading: controller.isLoading.value,
                      list: controller.leaveList,
                      noDataWidget: const MyNoData(),
                      builderWidget: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: SizeUtils.scale(10, size.width)),
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
