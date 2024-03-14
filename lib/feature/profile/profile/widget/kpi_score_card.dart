import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:flutter/material.dart';

class KpiScoreCard extends StatelessWidget {
  final String score;

  const KpiScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize().paddingHorizontalMedium,
              size.width,
            ),
            vertical: SizeUtils.scale(
              AppSize().paddingVerticalSmall,
              size.width,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SizeUtils.scale(AppSize().borderRadiusLarge, size.width),
            ),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
          ),
          child: Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: Theme.of(context).colorScheme.onPrimary,
                size: SizeUtils.scale(30, size.width),
              ),
              SizedBox(width: SizeUtils.scale(10, size.width)),
              Flexible(
                child: MyText(
                  text: "${"Performance Score:".trString} $score",
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts().bodyLargeSemi.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: SizeUtils.scale(10, size.width),
          top: SizeUtils.scale(10, size.width),
          child: Icon(
            Icons.star_rounded,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
            size: SizeUtils.scale(25, size.width),
          ),
        ),
        Positioned(
          right: SizeUtils.scale(20, size.width),
          top: SizeUtils.scale(18, size.width),
          child: Icon(
            Icons.star_rounded,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
            size: SizeUtils.scale(48, size.width),
          ),
        ),
      ],
    );
  }
}
