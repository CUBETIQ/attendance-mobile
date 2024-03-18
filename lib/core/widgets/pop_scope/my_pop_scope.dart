import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/utils/logger.dart';

class MyPopScope extends StatelessWidget {
  const MyPopScope({
    super.key,
    required this.child,
    this.onPopInvoked,
    this.onWillPop,
  });

  final Widget child;
  final void Function(bool)? onPopInvoked;
  final Future<bool> Function()? onWillPop;

  @override
  Widget build(BuildContext context) {
    int popped = 0;
    Future<bool> handlePop() async {
      DateTime initTime = DateTime.now();
      popped += 1;
      Logs.e('popped: $popped');
      if (popped >= 2) {
        return true;
      } else {
        showExitSnackBar('Do you want to exit?', ' ');
        await Future.delayed(const Duration(seconds: 2));
        if (DateTime.now().difference(initTime) >= const Duration(seconds: 2)) {
          popped = 0;
        }
        return false;
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: onPopInvoked ??
          (didPop) async {
            if (didPop) {
              return;
            }
            final shouldPop = await onWillPop?.call() ?? await handlePop();
            if (shouldPop) {
              Get.back(closeOverlays: true);
            }
          },
      child: child,
    );
  }
}
