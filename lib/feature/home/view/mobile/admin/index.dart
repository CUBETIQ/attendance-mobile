import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/extensions/string.dart';
import 'package:attendance_app/feature/home/controller/index.dart';
import 'package:attendance_app/feature/home/view/mobile/staff/index.dart';
import 'package:flutter/material.dart';

class HomeAdminMobileView extends StatelessWidget {
  const HomeAdminMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.to;
    return Column(
      children: [
        TabBar(
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
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 600,
                      color: Colors.red,
                    ),
                    Container(
                      height: 100,
                      color: Colors.blue,
                    ),
                  ],
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