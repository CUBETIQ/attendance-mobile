import 'package:attendance_app/feature/home/controller/index.dart';
import 'package:flutter/material.dart';

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.to;
    return Column(
      children: [
        TabBar(
          controller: controller.tabController,
          tabs: [
            Tab(
              text: 'Admin',
            ),
            Tab(
              text: 'DashBoard',
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
              Center(
                child: Text('DashBoard'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
