import 'package:flutter/material.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/padding.dart';
import 'package:timesync/utils/size_util.dart';

class OverviewCard extends StatelessWidget {
  final int? presence;
  final int? absence;
  final int? leave;
  final String? lateness;

  const OverviewCard({
    super.key,
    this.presence,
    this.absence,
    this.leave,
    this.lateness,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(
          SizeUtils.scale(AppSize().borderRadiusMedium, size.width),
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.scale(16, size.width),
          vertical: SizeUtils.scale(12, size.width),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCard(
              context: context,
              label: "Presence",
              value: (presence ?? 0).toString(),
            ),
            _buildCard(
              context: context,
              label: "Absence",
              value: (absence ?? 0).toString(),
            ),
            _buildCard(
              context: context,
              label: "Lateness",
              value: (lateness ?? '').toString(),
            ),
            _buildCard(
              context: context,
              label: "Leave",
              value: (leave ?? 0).toString(),
            ),
          ].withDivide(
              color: const Color(0xFFDCDEE3),
              height: SizeUtils.scale(40, size.width),
              width: SizeUtils.scale(1, size.width)),
        ),
      ),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required String label,
    required String value,
  }) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: SizeUtils.scale(5, size.width)),
          child: MyText(text: label, style: AppFonts.LabelXSmall),
        ),
        MyText(text: value, style: AppFonts.TitleMedium),
      ],
    );
  }
}
