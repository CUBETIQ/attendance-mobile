import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/async_widget/async_base_widget.dart';
import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/no_data/no_data.dart';
import 'package:timesync360/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/feature/department/department/controller/index.dart';
import 'package:timesync360/feature/department/department/widget/department_card.dart';
import 'package:timesync360/utils/size_util.dart';

class DepartmentViewMobile extends StatelessWidget {
  const DepartmentViewMobile({super.key});

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
                  AppSize.paddingHorizontalLarge,
                  size.width,
                ),
                horizontal: AppSize.paddingVerticalLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(text: "Department Overview", style: BodyLargeMedium),
                  const SizedBox(height: AppSize.paddingS8),
                  SearchBar(
                    hintText: "Search Department",
                    elevation: MaterialStateProperty.all<double>(0.2),
                    onSubmitted: controller.searchDepartment,
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
                  const SizedBox(height: AppSize.paddingS8),
                  Obx(
                    () => MyAsyncWidget(
                      isLoading: controller.isLoading.value,
                      list: controller.departmentList.value,
                      noDataWidget: const MyNoData(),
                      builderWidget: ListView.separated(
                        itemCount: controller.departmentList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                          height: SizeUtils.scale(
                            AppSize.paddingS8,
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
                ],
              ),
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
        elevation: 2,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}