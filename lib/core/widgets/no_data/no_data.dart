import 'package:timesync360/config/app_size.dart';
import 'package:timesync360/config/font.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyNoData extends StatelessWidget {
  const MyNoData({super.key, this.paddingTop});

  final double? paddingTop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop ?? 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 85,
            height: 85,
            child: SvgPicture.asset(
              SvgAssets.empty,
            ),
          ),
          const SizedBox(height: AppSize.paddingS5),
          Text(
            "No Data Available",
            style: BodyLargeMedium,
          ),
          const SizedBox(height: AppSize.paddingS8),
        ],
      ),
    );
  }
}
