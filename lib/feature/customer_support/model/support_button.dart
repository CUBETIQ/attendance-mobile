import 'package:flutter/material.dart';

class SupportButtonModel {
  final String title;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final void Function()? onTap;

  SupportButtonModel({
    required this.title,
    required this.leadingIcon,
    required this.trailingIcon,
    this.onTap,
  });
}
