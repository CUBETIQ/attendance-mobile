import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvg extends StatelessWidget {
  final String svg;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const CustomSvg(
      {super.key,
      this.height,
      this.width,
      required this.svg,
      this.color,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svg,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null
          ? ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            )
          : null,
      height: height ?? 24,
      width: width ?? 24,
    );
  }
}
