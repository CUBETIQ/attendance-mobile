import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyPage extends StatelessWidget {
  final String? image;
  final double? width;
  final double? height;
  final String? title;
  final String? description;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  const MyPage({
    super.key,
    this.image,
    this.width,
    this.height,
    this.title,
    this.description,
    this.titleStyle,
    this.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: SvgPicture.asset(
            image ?? "",
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.scale(
              AppSize().paddingHorizontalLarge,
              MediaQuery.of(context).size.width,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText(
                text: title ?? "Title",
                style: titleStyle ?? BodyXXlargeMedium,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.02),
              MyText(
                text: description ?? "Description",
                style: descriptionStyle ?? BodyMediumMedium,
                maxLines: 8,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
