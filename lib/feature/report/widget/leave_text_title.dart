import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';

class LeaveTextTitle extends StatelessWidget {
  const LeaveTextTitle({super.key, required this.leaves});

  final RxList<LeaveModel> leaves;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => leaves.value.isEmpty
          ? const SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeUtils.scale(12, size.width)),
              child: MyText(
                text: 'Leave',
                style: AppFonts.TitleMedium.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
    );
  }
}
