import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/card/my_card.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/string_util.dart';
import 'package:flutter/material.dart';

class SummaryDetailCard extends StatelessWidget {
  const SummaryDetailCard({
    super.key,
    required this.staff,
    required this.status,
    this.valueColor,
  });

  final UserModel staff;
  final String status;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyCard(
      width: size.width,
      height: SizeUtils.scale(60, size.width),
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.scale(
          AppSize.paddingHorizontalLarge,
          size.width,
        ),
      ),
      child: Row(
        children: [
          Row(
            children: [
              MyCacheImage(
                imageUrl: staff.image,
                width: SizeUtils.scale(40, size.width),
                height: SizeUtils.scale(40, size.width),
              ),
              SizedBox(width: SizeUtils.scale(10, size.width)),
              MyText(
                text: StringUtil().getfullname(
                  staff.firstName,
                  staff.lastName,
                  staff.username,
                ),
                style: BodyMediumMedium,
              ),
            ],
          ),
          const Spacer(),
          MyText(
            text: status,
            style: BodyMediumMedium.copyWith(
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
