import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/types_helper/user_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffCard extends StatelessWidget {
  final double? cardWidth;
  final double? cardHeight;
  final UserModel staff;

  const StaffCard({
    super.key,
    this.cardWidth,
    this.cardHeight,
    required this.staff,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: cardWidth ?? size.width,
      height: cardHeight ?? SizeUtils.scale(60, size.width),
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.scale(AppSize.paddingHorizontalLarge, size.width),
        vertical: SizeUtils.scale(AppSize.paddingS1, size.width),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeUtils.scale(AppSize.borderRadiusLarge, size.width),
        ),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          MyCacheImage(
            imageUrl: staff.image ?? "",
            width: SizeUtils.scale(40, size.width),
            height: SizeUtils.scale(40, size.width),
          ),
          SizedBox(width: SizeUtils.scale(AppSize.paddingS5, size.width)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text:
                    "${staff.firstName ?? staff.username ?? "Fullname"} ${staff.lastName ?? ""}",
                style: BodyMediumSemi,
              ),
              MyText(
                text: "Mobile App Dev",
                style: BodyMediumRegular,
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MyText(
                text: (staff.status ?? UserStatus.active).capitalizeFirst,
                style: BodyMediumRegular.copyWith(
                  color: staff.status != null
                      ? staff.status == UserStatus.active
                          ? Colors.green
                          : staff.status == UserStatus.idle
                              ? Colors.orange
                              : Colors.red
                      : Colors.green,
                ),
              ),
              Row(
                children: [
                  MyText(
                    text: "View Detail",
                    style: BodySmallRegular.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: SizeUtils.scale(5, size.width)),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: SizeUtils.scale(10, size.width),
                    color: Theme.of(context).colorScheme.primary,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
