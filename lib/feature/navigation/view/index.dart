import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/home/home/view/index.dart';
import 'package:timesync/feature/leave/leave/view/index.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/navigation/widget/side_drawer.dart';
import 'package:timesync/feature/profile/profile/view/index.dart';
import 'package:timesync/feature/report/view/index.dart';
import 'package:timesync/feature/task/task/controller/index.dart';
import 'package:timesync/feature/task/task/view/index.dart';
import 'package:timesync/routes/app_pages.dart';
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
        if (Get.currentRoute == Routes.NAVIGATION) {
          return false;
        } else {
          return false;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: SizeUtils.scale(10, size.width)),
            child: InkWell(
                onTap: controller.toggleDrawer,
                child: SvgIcon(
                    icon: IconAssets.menu,
                    color: Theme.of(context).colorScheme.onBackground)),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: SizeUtils.scale(20, size.width)),
              child: Obx(() {
                return controller
                            .items[controller.selectedIndex.value].actionIcon ==
                        null
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: controller
                            .items[controller.selectedIndex.value].actionOnTap,
                        child: SvgIcon(
                          icon: controller.items[controller.selectedIndex.value]
                              .actionIcon!,
                          height: controller
                              .items[controller.selectedIndex.value]
                              .actionHeight,
                          width: controller
                              .items[controller.selectedIndex.value]
                              .actionWidth,
                          color: controller
                                      .items[controller.selectedIndex.value]
                                      .hasColor ==
                                  true
                              ? null
                              : Theme.of(context).colorScheme.onBackground,
                        ));
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
                        ? () => getAddTaskBottomSheet(
                            onAddTask: TaskController.to.onAddTask)
                        // controller.onTapAddTask
                        : controller.onTapAddLeave,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          SizeUtils.scale(AppSpacing.L, size.width),
                        ),
                      ),
                    ),
                    child: Icon(
                      Icons.add_rounded,
                      size: SizeUtils.scale(24, size.width),
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            onDestinationSelected: controller.onDestinationSelected,
            selectedIndex: controller.selectedIndex.value,
            indicatorColor: Colors.transparent,
            destinations: controller.items
                .map(
                  (item) => NavigationDestination(
                    icon: SvgIcon(
                        icon: item.bottomIcon,
                        height: SizeUtils.scale(22, size.width),
                        width: SizeUtils.scale(22, size.width),
                        color: Theme.of(context).colorScheme.outlineVariant),
                    selectedIcon: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SvgIcon(
                            icon: item.bottomIcon,
                            height: SizeUtils.scale(22, size.width),
                            width: SizeUtils.scale(22, size.width),
                            color: Theme.of(context).colorScheme.primary),
                        Transform.translate(
                          offset: Offset(0, SizeUtils.scale(32, size.width)),
                          child: Container(
                            height: SizeUtils.scale(2, size.width),
                            width: SizeUtils.scale(22 * 3, size.width),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      ],
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
