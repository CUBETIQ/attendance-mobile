import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';

import '../../../constants/svg.dart';

class MyEmptyState extends StatelessWidget {
  const MyEmptyState({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: SizeUtils.scale(
                width ?? 188, MediaQuery.of(context).size.width),
            height: SizeUtils.scale(
                height ?? 188, MediaQuery.of(context).size.width),
            child: SvgPicture.asset(
              SvgAssets.emptyState,
            ),
          ),
        ),
        SizedBox(
          height: SizeUtils.scale(18, MediaQuery.of(context).size.width),
        ),
        MyText(
          text: "No data yet",
          style: AppFonts.TitleMedium,
        ),
        SizedBox(
          height: SizeUtils.scale(4, MediaQuery.of(context).size.width),
        ),
        MyText(
          text: "Currently, there is no data available.",
          style: AppFonts.BodySmall.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        MyText(
          text: "Please check back later.",
          style: AppFonts.BodySmall.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
