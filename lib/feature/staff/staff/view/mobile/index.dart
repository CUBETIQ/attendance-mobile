import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/async_widget/async_base_widget.dart';
import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/no_data/no_data.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/staff/staff/controller/index.dart';
import 'package:attendance_app/feature/staff/staff/widget/staff_card.dart';
import 'package:attendance_app/utils/size_util.dart';
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
          title: "Staff",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeUtils.scale(
                AppSize.paddingHorizontalLarge,
                MediaQuery.of(context).size.width,
              ),
              horizontal: AppSize.paddingVerticalLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: "Staff Overview", style: BodyLargeMedium),
                const SizedBox(height: AppSize.paddingS8),
                SearchBar(
                    hintText: "Search staff",
                    elevation: MaterialStateProperty.all<double>(0.8),
                    trailing: Iterable<Widget>.generate(
                      1,
                      (index) => IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                    )),
                const SizedBox(height: AppSize.paddingS8),
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
                          AppSize.paddingS8,
                          size.width,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        return StaffCard(
                          staff: controller.staffs[index],
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
    );
  }
}
