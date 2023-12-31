import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/utils/types_helper/user_status.dart';
import 'package:flutter/material.dart';

class StatusDot extends StatelessWidget {
  final String? status;

  const StatusDot({super.key, this.status});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: status == null
            ? Colors.green
            : status == UserStatus.active
                ? Colors.green
                : status == UserStatus.idle
                    ? Colors.yellow
                    : Colors.red,
        borderRadius: BorderRadius.circular(
          AppSize.borderRadiusLarge * (size.width / 375.0),
        ),
        border: Border.all(
          color: Colors.white,
          width: 1.3,
        ),
      ),
    );
  }
}
