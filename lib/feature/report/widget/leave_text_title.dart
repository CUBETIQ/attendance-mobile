import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/leave_model.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              padding: EdgeInsets.only(
                left: SizeUtils.scale(
                  AppSize.paddingHorizontalLarge,
                  size.width,
                ),
                top: SizeUtils.scale(10, size.width),
                bottom: SizeUtils.scale(10, size.width),
              ),
              child: MyText(
                text: 'On Leave',
                style: BodyLargeMedium.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
    );
  }
}
