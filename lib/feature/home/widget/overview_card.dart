import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OverviewCard extends StatelessWidget {
  final String image;
  final String? number;
  final String? title;
  final double? height;

  const OverviewCard({
    super.key,
    required this.image,
    this.number,
    this.title,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: height ?? size.width * 0.25,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1.2,
            blurRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: size.height * 0.01,
                right: size.width * 0.02,
              ),
              width: size.height * 0.05,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
              child: SizedBox(
                width: size.height * 0.03,
                height: size.height * 0.03,
                child: SvgPicture.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.02,
              ),
              child: MyText(
                text: number ?? "0",
                style: BodyLargeMedium,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.02,
              ),
              child: MyText(
                text: title ?? "Title",
                style: BodySmallRegular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
