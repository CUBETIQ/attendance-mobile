import 'package:flutter/material.dart';

class BottomBarModel {
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final String? actionIcon;
  final Function()? actionOnTap;
  final double? actionHeight;
  final double? actionWidth;
  final bool? hasColor;

  BottomBarModel({
    required this.title,
    required this.icon,
    required this.selectedIcon,
    this.actionIcon,
    this.actionHeight,
    this.actionWidth,
    this.hasColor,
    this.actionOnTap,
  });
}
