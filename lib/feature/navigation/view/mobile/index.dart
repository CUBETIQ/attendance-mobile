import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/feature/home/view/index.dart';
import 'package:attendance_app/feature/leave/view/index.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/profile/profile/view/index.dart';
import 'package:attendance_app/feature/task/task/view/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationViewMobile extends StatelessWidget {
  const NavigationViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = NavigationController.to;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.75,
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Obx(
          () => MyAppBarTitle(
            title: controller.items[controller.selectedIndex.value].title,
          ),
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: const <Widget>[
            HomeView(),
            TaskView(),
            LeaveView(),
            ProfileView(),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => controller.selectedIndex.value != 1 &&
                controller.selectedIndex.value != 2
            ? const SizedBox.shrink()
            : FloatingActionButton(
                onPressed: controller.selectedIndex.value == 1
                    ? controller.onTapAddTask
                    : () {},
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                elevation: 2,
                child: const Icon(Icons.add),
              ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: controller.onDestinationSelected,
          selectedIndex: controller.selectedIndex.value,
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
