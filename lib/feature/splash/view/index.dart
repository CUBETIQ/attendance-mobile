import 'package:attendance_app/extensions/string.dart';
import 'package:attendance_app/feature/splash/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Splash'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(controller.title.capitalizeFirstLetter()),
          ],
        ),
      ),
    );
  }
}
