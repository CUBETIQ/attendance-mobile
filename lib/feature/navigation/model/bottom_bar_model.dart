import 'package:flutter/material.dart';

class BottomBarModel {
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final Widget? action;

  BottomBarModel({
    required this.title,
    required this.icon,
    required this.selectedIcon,
    this.action,
  });
}
