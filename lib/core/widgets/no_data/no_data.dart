import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timesync360/core/widgets/text/text.dart';

class MyNoData extends StatelessWidget {
  const MyNoData({super.key, this.paddingTop});

  final double? paddingTop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop ?? 0,
      ),
      child: Center(
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
            SizedBox(height: AppSize().paddingS5),
            MyText(
              text: "No Data Available",
              style: AppStyles().bodyLargeMedium,
            ),
            SizedBox(height: AppSize().paddingS8),
          ],
        ),
      ),
    );
  }
}
