import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/extensions/string.dart';
import 'package:attendance_app/feature/home/controller/index.dart';
import 'package:attendance_app/feature/home/view/mobile/staff_home_view.dart';
import 'package:attendance_app/feature/home/widget/pie_chart_card.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';

class HomeAdminMobileView extends StatelessWidget {
  const HomeAdminMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.to;
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: TabBar(
            controller: controller.tabController,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            labelStyle: BodyLargeMedium,
            unselectedLabelStyle: BodyLargeMedium,
            unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
            labelColor: Theme.of(context).colorScheme.onBackground,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(
                text: 'Dashboard'.trString,
              ),
              Tab(
                text: 'Attendance'.trString,
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeUtils.scale(
                      AppSize.paddingHorizontalLarge,
                      MediaQuery.of(context).size.width,
                    ),
                    right: SizeUtils.scale(
                      AppSize.paddingHorizontalLarge,
                      MediaQuery.of(context).size.width,
                    ),
                    top: AppSize.paddingVerticalLarge,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AttendancePieChartCard(),
                    ],
                  ),
                ),
              ),
              const HomeStaffMobileView(),
            ],
          ),
        ),
      ],
    );
  }
}
