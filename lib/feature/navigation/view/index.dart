import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/home/home/view/index.dart';
import 'package:timesync/feature/leave/leave/view/index.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/navigation/widget/side_drawer.dart';
import 'package:timesync/feature/profile/profile/view/index.dart';
import 'package:timesync/feature/report/view/index.dart';
import 'package:timesync/feature/task/task/view/index.dart';
import 'package:timesync/utils/size_util.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = NavigationController.to;
    final mediaQuery = MediaQuery.of(context);
    return ZoomDrawer(
      controller: controller.zoomDrawerController,
      menuScreen: Obx(
        () => SideDrawer(
          imageUrl: controller.user.value.image,
          drawerItems: controller.drawerItems,
          user: controller.user.value,
        ),
      ),
      mainScreen: const MainScreen(),
      borderRadius: SizeUtils.scale(AppSize().borderRadiusLarge, context.width),
      showShadow: false,
      angle: -10.0,
      androidCloseOnBackTap: true,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.10),
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
        mediaQuery.orientation == Orientation.landscape &&
                mediaQuery.size.width < 1150
            ? mediaQuery.size.width * 0.31
            : 238,
        mediaQuery.size.width,
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = NavigationController.to;
    final size = MediaQuery.of(context).size;
    return BackButtonListener(
      onBackButtonPressed: () async {
        if (Get.currentRoute == '/navigation') {
          return false;
        } else {
          return false;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: controller.toggleDrawer,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: SizeUtils.scale(10, size.width)),
              child: Obx(() {
                return controller
                            .items[controller.selectedIndex.value].actionIcon ==
                        null
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: controller
                            .items[controller.selectedIndex.value].actionOnTap,
                        child: SvgPicture.asset(
                          height: controller
                              .items[controller.selectedIndex.value]
                              .actionHeight,
                          width: controller
                              .items[controller.selectedIndex.value]
                              .actionWidth,
                          controller.items[controller.selectedIndex.value]
                              .actionIcon!,
                          colorFilter: controller
                                      .items[controller.selectedIndex.value]
                                      .hasColor ==
                                  true
                              ? null
                              : ColorFilter.mode(
                                  Theme.of(context).colorScheme.onBackground,
                                  BlendMode.srcIn),
                        ),
                      );
              }),
            ),
          ],
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
              ReportView(),
              TaskView(),
              LeaveView(),
              ProfileView(),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: SizeUtils.scale(40, size.width),
          width: SizeUtils.scale(40, size.width),
          child: Obx(
            () => controller.selectedIndex.value != 2 &&
                    controller.selectedIndex.value != 3
                ? const SizedBox.shrink()
                : FloatingActionButton(
                    onPressed: controller.selectedIndex.value == 2
                        ? controller.onTapAddTask
                        : controller.onTapAddLeave,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    child: Icon(
                      Icons.add_rounded,
                      size: SizeUtils.scale(24, size.width),
                    ),
                  ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            onDestinationSelected: controller.onDestinationSelected,
            selectedIndex: controller.selectedIndex.value,
            destinations: controller.items
                .map(
                  (item) => NavigationDestination(
                    icon: Icon(
                      item.icon,
                      size: SizeUtils.scale(22, size.width),
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    selectedIcon: Icon(
                      item.selectedIcon,
                      size: SizeUtils.scale(22, size.width),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: item.title.tr,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
