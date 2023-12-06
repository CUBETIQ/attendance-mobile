import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
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
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingHorizontalLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: title ?? "Title",
                style: titleStyle ?? BodyXXlargeMedium,
                maxLines: 2,
              ),
              SizedBox(height: size.height * 0.01),
              MyText(
                text: description ?? "Description",
                style: descriptionStyle ?? BodyMediumMedium,
                maxLines: 8,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        )
      ],
    );
  }
}
