import 'package:timesync360/utils/types_helper/role.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleBaseLayOut extends StatelessWidget {
  final Widget admin;
  final Widget staff;
  final RxString role;
  const RoleBaseLayOut({
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
