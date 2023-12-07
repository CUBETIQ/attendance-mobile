import 'package:attendance_app/utils/types/user_status.dart';
import 'package:flutter/material.dart';

class StatusDot extends StatelessWidget {
  final String? status;

  const StatusDot({super.key, this.status});

  @override
  Widget build(BuildContext context) {
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white,
          width: 1.3,
        ),
      ),
    );
  }
}
