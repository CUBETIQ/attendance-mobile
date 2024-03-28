import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';
import 'package:timesync/types/user_status.dart';
import 'package:flutter/material.dart';

class StaffCard extends StatelessWidget {
  final double? cardWidth;
  final double? cardHeight;
  final UserModel staff;
  final String? position;
  final void Function()? onTap;
  final void Function()? onTapViewDetail;

  const StaffCard({
    super.key,
    this.cardWidth,
    this.cardHeight,
    required this.staff,
    this.position,
    this.onTap,
    this.onTapViewDetail,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth ?? size.width,
        padding: EdgeInsets.symmetric(
          horizontal:
              SizeUtils.scale(AppSize().paddingHorizontalMedium, size.width),
          vertical: SizeUtils.scale(AppSize().paddingS4, size.width),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeUtils.scale(AppSize().borderRadiusLarge, size.width),
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
            Stack(
              children: [
                SizedBox(
                  width: SizeUtils.scale(40, size.width),
                  height: SizeUtils.scale(40, size.width),
                ),
                MyCacheImage(
                  imageUrl: staff.image ?? "",
                  width: SizeUtils.scale(40, size.width),
                  height: SizeUtils.scale(40, size.width),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: SizeUtils.scale(12, size.width),
                    height: SizeUtils.scale(12, size.width),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: staff.status != null
                          ? staff.status == UserStatus.active
                              ? Colors.green
                              : staff.status == UserStatus.idle
                                  ? Colors.orange
                                  : Colors.red
                          : Colors.green,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.background,
                        width: SizeUtils.scale(1.5, size.width),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: SizeUtils.scale(AppSize().paddingS5, size.width)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: SizeUtils.scale(140, size.width),
                  ),
                  child: MyText(
                    text: StringUtil.getfullname(
                      staff.firstName,
                      staff.lastName,
                      staff.username,
                    ),
                    style: AppFonts().bodyMediumSemi,
                    maxLines: 2,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: SizeUtils.scale(140, size.width),
                  ),
                  child: MyText(
                    maxLines: 2,
                    text: position ?? "-",
                    style: AppFonts().bodyMediumRegular,
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: onTapViewDetail,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.scale(5, size.width),
                  vertical: SizeUtils.scale(2, size.width),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    SizeUtils.scale(AppSize().borderRadiusLarge, size.width),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText(
                      text: "View Detail",
                      style: AppFonts().bodySmallRegular.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    SizedBox(width: SizeUtils.scale(2, size.width)),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: SizeUtils.scale(10, size.width),
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
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
