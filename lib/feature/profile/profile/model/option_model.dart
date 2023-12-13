import 'package:flutter/material.dart';

class OptionModel {
  final String? image;
  final String? title;
  final IconData? icon;
  final void Function()? onTap;

  OptionModel({
    this.image,
    this.title,
    this.icon,
    this.onTap,
  });
}
