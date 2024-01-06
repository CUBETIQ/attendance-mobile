import 'package:flutter/material.dart';

class DrawerModel {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  DrawerModel({required this.title, required this.icon, this.onTap});
}
