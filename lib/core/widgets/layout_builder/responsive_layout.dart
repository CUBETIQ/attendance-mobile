import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget tablet;
  final Widget mobile;
  const ResponsiveLayout(
      {super.key, required this.tablet, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return mobile;
      } else {
        return tablet;
      }
    });
  }
}
