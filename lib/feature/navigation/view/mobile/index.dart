import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:flutter/cupertino.dart';
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
        bottom: false,
        child: Obx(
          () => IndexedStack(
            index: controller.selectedIndex.value,
            children: const <Widget>[
              Center(child: Text('Home')),
              Center(child: Text('Notifications')),
              Center(child: Text('Messages')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: controller.onDestinationSelected,
          selectedIndex: controller.selectedIndex.value,
          elevation: 2,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home_rounded),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Badge(child: Icon(Icons.notifications_rounded)),
              icon: Badge(child: Icon(Icons.notifications_outlined)),
              label: 'Notifications',
            ),
            NavigationDestination(
              selectedIcon: Icon(CupertinoIcons.doc_chart_fill),
              icon: Icon(CupertinoIcons.doc_chart),
              label: 'Messages',
            ),
          ],
        ),
      ),
    );
  }
}
