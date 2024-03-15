import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/no_data/no_data.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/department/department/controller/index.dart';
import 'package:timesync/feature/department/department/widget/department_card.dart';
import 'package:timesync/utils/size_util.dart';

class DepartmentView extends StatelessWidget {
  const DepartmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DepartmentController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Department",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: MyRefreshIndicator(
        onRefresh: controller.onRefresh,
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeUtils.scale(
                AppSize().paddingHorizontalLarge,
                size.width,
              ),
              horizontal: AppSize().paddingVerticalLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                  text: "Department Overview",
                  style: AppFonts().bodyLargeMedium,
                ),
                SizedBox(height: AppSize().paddingS8),
                SizedBox(
                  height: SizeUtils.scale(50, size.width),
                  child: SearchBar(
                    hintText: "Search Department",
                    elevation: MaterialStateProperty.all<double>(0.2),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      AppFonts().bodyMediumMedium.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    constraints: BoxConstraints.loose(size),
                    onSubmitted: controller.searchDepartment,
                    onChanged: controller.searchDepartment,
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
                        iconSize: SizeUtils.scale(20, size.width),
                      ),
                    ],
                    controller: controller.searchController,
                  ),
                ),
                SizedBox(height: AppSize().paddingS8),
                Expanded(
                  child: Obx(
                    () => MyAsyncWidget(
                      isLoading: controller.isLoading.value,
                      list: controller.departmentList.value,
                      noDataWidget: const MyNoData(),
                      builderWidget: ListView.separated(
                        itemCount: controller.departmentList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(SizeUtils.scale(1, size.width)),
                        physics: const AlwaysScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                          height: SizeUtils.scale(
                            AppSize().paddingS8,
                            size.width,
                          ),
                        ),
                        itemBuilder: (context, index) {
                          return DepartmentCard(
                            onTap: () => controller.onTapDepartment(
                              controller.departmentList[index],
                            ),
                            onTapViewDetail: () =>
                                controller.onTapDepartmentDetail(
                              controller.departmentList[index],
                            ),
                            department: controller.departmentList[index],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onTapAddDepartment,
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
