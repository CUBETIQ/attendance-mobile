import 'package:flutter/material.dart';

class WillPopScopeCustom extends StatelessWidget {
  const WillPopScopeCustom({super.key, required this.child, this.onWillPop});

  final Widget child;
  final Future<bool> Function()? onWillPop;

  @override
  Widget build(BuildContext context) {
    int popped = 0;
    return WillPopScope(
      onWillPop: onWillPop ??
          () async {
            DateTime initTime = DateTime.now();
            popped += 1;

            if (popped >= 2) {
              return true;
            } else {
              // showAlertSnackBar('Exit', 'Are you sure you wanna exit?');
              await Future.delayed(const Duration(seconds: 2));
              if (DateTime.now().difference(initTime) >=
                  const Duration(seconds: 2)) {
                popped = 0;
              }
              return false;
            }
          },
      child: child,
    );
  }
}
