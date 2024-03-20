import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timesync/utils/size_util.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({super.key, this.width, this.height, required this.icon});

  final double? width;
  final double? height;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: width ?? SizeUtils.scale(24, size.width),
      height: height ?? SizeUtils.scale(24, size.width),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        icon,
        width: width ?? SizeUtils.scale(24, size.width),
        height: height ?? SizeUtils.scale(24, size.width),
      ),
    );
  }
}
