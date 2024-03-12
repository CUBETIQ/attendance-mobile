import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/department_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/no_data/no_data.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/employee/employee/controller/index.dart';
import 'package:timesync/feature/employee/employee/widget/staff_card.dart';
import 'package:timesync/utils/size_util.dart';

class StaffView extends StatelessWidget {
  const StaffView({super.key});

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
                    style: AppFonts().bodyLargeMedium,
                  ),
                  SizedBox(height: AppSize().paddingS8),
                  SizedBox(
                    height: SizeUtils.scale(50, size.width),
                    child: SearchBar(
                      hintText: "Search Employee",
                      elevation: MaterialStateProperty.all<double>(0.8),
                      onSubmitted: controller.searchStaff,
                      constraints: BoxConstraints.loose(size),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        AppFonts().bodyMediumMedium.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(
                          horizontal: SizeUtils.scale(
                            AppSize().paddingS5,
                            size.width,
                          ),
                        ),
                      ),
                      leading: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {},
                        icon: const Icon(Icons.search_rounded),
                        iconSize: SizeUtils.scale(20, size.width),
                      ),
                      trailing: [
                        IconButton(
                          onPressed: controller.clearSearch,
                          icon: const Icon(Icons.cancel_rounded),
                        ),
                      ],
                      controller: controller.searchController,
                    ),
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
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
