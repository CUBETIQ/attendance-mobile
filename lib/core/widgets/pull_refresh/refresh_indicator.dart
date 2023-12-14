import 'package:flutter/material.dart';

class MyRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final double? height;

  const MyRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      displacement: height ?? size.height * 0.1,
      onRefresh: onRefresh,
      child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: ScrollConfiguration(
              behavior: const ScrollBehavior(), child: child)),
    );
  }
}
