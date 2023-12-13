import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/feature/home/view/index.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/profile/profile/view/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationViewMobile extends StatelessWidget {
  const NavigationViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = NavigationController.to;
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => MyAppBarTitle(
            title: controller.titles[controller.selectedIndex.value],
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: controller.selectedIndex.value,
            children: const <Widget>[
              HomeView(),
              Center(child: Text('Notifications')),
              ProfileView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: controller.onDestinationSelected,
          selectedIndex: controller.selectedIndex.value,
          elevation: 2,
          destinations: controller.items
              .map(
                (item) => NavigationDestination(
                  icon: Icon(item.icon),
                  selectedIcon: Icon(item.selectedIcon),
                  label: item.title,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
