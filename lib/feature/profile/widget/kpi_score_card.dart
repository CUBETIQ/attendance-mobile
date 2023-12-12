import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:flutter/material.dart';

class KpiScoreCard extends StatelessWidget {
  final String score;

  const KpiScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width - 48,
      height: size.width * 0.2,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.paddingHorizontalLarge,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.borderRadiusLarge * (size.width / 375.0),
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        children: [
          Icon(
            Icons.star_rounded,
            color: Theme.of(context).colorScheme.onPrimary,
            size: size.width * 0.1,
          ),
          SizedBox(width: size.width * 0.02),
          MyText(
            text: "Performance Score: $score",
            style: BodyLargeSemi.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
