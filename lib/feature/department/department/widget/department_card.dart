import 'package:timesync360/constants/app_size.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/widgets/card/my_card.dart';
import 'package:timesync360/core/widgets/image/cache_image.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';

class DepartmentCard extends StatelessWidget {
  const DepartmentCard({
    super.key,
    required this.department,
    this.onTap,
    this.onTapViewDetail,
  });

  final DepartmentModel department;
  final void Function()? onTap;
  final void Function()? onTapViewDetail;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: MyCard(
        width: size.width,
        height: SizeUtils.scaleMobile(60, size.width),
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.scaleMobile(
              AppSize().paddingHorizontalLarge, size.width),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MyCacheImage(
                  imageUrl: department.image ?? "",
                  defaultImage: SvgAssets.position,
                  width: SizeUtils.scaleMobile(45, size.width),
                  height: SizeUtils.scaleMobile(45, size.width),
                  imageWidth: SizeUtils.scaleMobile(30, size.width),
                  imageHeight: SizeUtils.scaleMobile(30, size.width),
                ),
                SizedBox(width: SizeUtils.scaleMobile(10, size.width)),
                MyText(
                  text: department.name ?? "",
                  style: AppFonts().bodyMediumMedium,
                ),
              ],
            ),
            GestureDetector(
              onTap: onTapViewDetail,
              child: Container(
                padding: EdgeInsets.all(
                  SizeUtils.scaleMobile(5, size.width),
                ),
                child: Row(
                  children: [
                    MyText(
                      text: "View Detail",
                      style: AppFonts().bodySmallMedium.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    SizedBox(width: SizeUtils.scaleMobile(5, size.width)),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: SizeUtils.scaleMobile(15, size.width),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
