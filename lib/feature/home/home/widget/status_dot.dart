import 'package:timesync/constants/app_size.dart';
import 'package:timesync/types/user_status.dart';
import 'package:flutter/material.dart';
import 'package:timesync/utils/size_util.dart';

class StatusDot extends StatelessWidget {
  final String? status;

  const StatusDot({super.key, this.status});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: SizeUtils.scale(12, size.width),
      height: SizeUtils.scale(12, size.width),
      decoration: BoxDecoration(
        color: status == null
            ? Colors.green
            : status == UserStatus.active
                ? Colors.green
                : status == UserStatus.idle
                    ? Colors.yellow
                    : Colors.red,
        borderRadius: BorderRadius.circular(
          AppSize().borderRadiusLarge * (size.width / 375.0),
        ),
        border: Border.all(
          color: Colors.white,
          width: 1.3,
        ),
      ),
    );
  }
}
