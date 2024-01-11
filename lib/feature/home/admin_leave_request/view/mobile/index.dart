import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/dropdown_button/date_dropdown.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/home/admin_leave_request/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../core/widgets/async_widget/async_base_widget.dart';

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
      body: SingleChildScrollView(
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
                height:
                    SizeUtils.scale(AppSize.paddingVerticalLarge, size.width),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(text: "Employee Leave", style: BodyXlargeMedium),
                  Obx(
                    () => DateDropDown(
                      date: controller.selectDate.value,
                      size: size,
                      onTap: controller.onTapDate,
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeUtils.scale(20, size.width)),
              // MyAsyncWidget(
              //   isLoading: controller.isLoadingList.value,
              //   list: controller.attendanceList,
              //   noDataWidget: const MyNoData(),
              //   builderWidget: ListView.separated(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     separatorBuilder: (context, index) =>
              //         SizedBox(height: SizeUtils.scale(10, size.width)),
              //     itemCount: controller.staffAttendanceList.value.length,
              //     itemBuilder: (context, index) {
              //       final attendance =
              //           controller.staffAttendanceList.value[index];
              //       Console.log("Staff Attendance", attendance);
              //       final staff = controller.staffs.firstWhere(
              //           (element) => element.id == attendance.userId,
              //           orElse: () => UserModel());
              //       return StaffAttendanceCard(
              //         staff: staff,
              //         attendance: attendance,
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
