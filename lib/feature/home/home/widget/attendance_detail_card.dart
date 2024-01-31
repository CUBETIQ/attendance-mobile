import 'package:timesync360/config/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AttendanceDetailCard extends StatelessWidget {
  final String image;
  final String? time;
  final String title;
  final double? iconWidth;
  final double? iconHeight;
  final TextStyle? titleStyle;
  final TextStyle? timeStyle;

  const AttendanceDetailCard({
    super.key,
    required this.image,
    this.time,
    required this.title,
    this.iconWidth,
    this.iconHeight,
    this.titleStyle,
    this.timeStyle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          image,
          width: iconWidth ?? size.height * 0.025,
          height: iconHeight ?? size.height * 0.025,
        ),
        MyText(
          text: time == null || time == "null" ? "--:--" : time!,
          style: timeStyle ?? BodyMediumRegular,
        ),
        MyText(
          text: title,
          style: titleStyle ?? BodyMediumRegular,
        ),
      ],
    );
  }
}
