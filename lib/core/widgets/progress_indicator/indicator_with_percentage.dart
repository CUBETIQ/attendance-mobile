import 'package:flutter/material.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';

import '../../../utils/size_util.dart';

class ProgressIndicatorWithPercentage extends StatelessWidget {
  const ProgressIndicatorWithPercentage({
    super.key,
    this.width,
    this.height,
    required this.percentage,
    this.textStyle,
  });

  final double? width;
  final double? height;
  final double percentage;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: SizeUtils.scale(25, size.width),
            height: SizeUtils.scale(25, size.width),
            child: CircularProgressIndicator(
              strokeWidth: 3.5,
              value: percentage,
            ),
          ),
        ),
        Center(
          child: MyText(
            text: "${(percentage * 100).toStringAsFixed(0)}%",
            style: AppFonts().bodyXSmallMedium,
          ),
        ),
      ],
    );
  }
}
