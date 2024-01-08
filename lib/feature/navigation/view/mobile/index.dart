import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/feature/home/home/view/index.dart';
import 'package:attendance_app/feature/leave/leave/view/index.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/navigation/widget/side_drawer.dart';
import 'package:attendance_app/feature/profile/profile/view/index.dart';
import 'package:attendance_app/feature/task/task/view/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class NavigationViewMobile extends StatelessWidget {
  const NavigationViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = NavigationController.to;
    return ZoomDrawer(
      controller: controller.zoomDrawerController,
      menuScreen: SideDrawer(
        imageUrl: controller.user.value.image,
      ),
      mainScreen: const MainScreen(),
      borderRadius: SizeUtils.scale(AppSize.borderRadiusLarge, context.width),
      showShadow: false,
      angle: -10.0,
      androidCloseOnBackTap: true,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.25),
          spreadRadius: 4,
          blurRadius: 4,
          offset: const Offset(-5, 10),
        ),
      ],
      menuBackgroundColor: Theme.of(context).colorScheme.background,
      duration: 300.milliseconds,
      reverseDuration: 200.milliseconds,
      mainScreenTapClose: true,
      slideWidth: SizeUtils.scale(
        MediaQuery.of(context).size.width * 0.65,
        context.width,
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = NavigationController.to;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: controller.toggleDrawer,
        ),
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
                    : controller.onTapAddLeave,
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
