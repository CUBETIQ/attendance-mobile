import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/no_data/no_data.dart';
import 'package:timesync360/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/employee/employee/controller/index.dart';
import 'package:timesync360/feature/employee/employee/widget/staff_card.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class StaffViewMobile extends StatelessWidget {
  const StaffViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = StaffController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Employee",
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
                vertical: SizeUtils.scale(
                  AppSize().paddingHorizontalLarge,
                  MediaQuery.of(context).size.width,
                ),
                horizontal: AppSize().paddingVerticalLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Employee Overview",
                    style: AppStyles().bodyLargeMedium,
                  ),
                  SizedBox(height: AppSize().paddingS8),
                  SearchBar(
                    hintText: "Search Employee",
                    elevation: MaterialStateProperty.all<double>(0.8),
                    onSubmitted: controller.searchStaff,
                    leading: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {},
                      icon: const Icon(Icons.search_rounded),
                    ),
                    trailing: [
                      IconButton(
                        onPressed: controller.clearSearch,
                        icon: const Icon(Icons.cancel_rounded),
                      ),
                    ],
                    controller: controller.searchController,
                  ),
                  SizedBox(height: AppSize().paddingS8),
                  Obx(
                    () => MyAsyncWidget(
                      isLoading: controller.isLoading.value,
                      list: controller.staffs,
                      noDataWidget: const MyNoData(),
                      builderWidget: ListView.separated(
                        itemCount: controller.staffs.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                          height: SizeUtils.scale(
                            AppSize().paddingS8,
                            size.width,
                          ),
                        ),
                        itemBuilder: (context, index) {
                          final staff = controller.staffs[index];
                          final position = controller.positions.firstWhere(
                            (element) => element.id == staff.positionId,
                            orElse: () => PositionModel(),
                          );
                          final department = controller.departments.firstWhere(
                            (element) => element.id == staff.departmentId,
                            orElse: () => DepartmentModel(),
                          );
                          return StaffCard(
                            onTapViewDetail: () => controller.onTapViewDetail(
                                staff, position, department),
                            onTap: () => controller.onTapStaff(staff),
                            staff: controller.staffs[index],
                            position: position.name,
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
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onTapAddStaff,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        elevation: 2,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
