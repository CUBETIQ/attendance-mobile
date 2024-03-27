import 'package:flutter/material.dart';
import 'package:timesync/constants/app_spacing.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/types/leave.dart';
import 'package:timesync/utils/size_util.dart';

class LeaveCard extends StatelessWidget {
  final LeaveModel leave;
  final void Function()? onTap;
  final double? width;
  final double? height;

  const LeaveCard({
    super.key,
    required this.leave,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: leave.status != LeaveStatus.pending ? null : onTap,
      child: Container(
        width: size.width,
        height: SizeUtils.scale(97, size.width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeUtils.scale(AppSpacing.L, size.width),
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
      ),
    );
  }
}
