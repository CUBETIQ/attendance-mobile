import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: SizedBox(
            width: width,
            height: height,
            child: SvgPicture.asset(
              image ?? "",
            ),
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
                style: titleStyle ?? AppFonts().bodyXXlargeMedium,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.02),
              MyText(
                text: description ?? "Description",
                style: descriptionStyle ?? AppFonts().bodyMediumMedium,
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
