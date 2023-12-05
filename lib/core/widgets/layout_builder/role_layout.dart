import 'package:attendance_app/utils/role.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleLayOut extends StatelessWidget {
  final Widget admin;
  final Widget staff;
  final RxString role;
  const RoleLayOut({
    super.key,
    required this.admin,
    required this.staff,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => role.value == Role.staff ? staff : admin,
    );
  }
}
