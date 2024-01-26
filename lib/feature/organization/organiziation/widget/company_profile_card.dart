import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/widgets/button/button.dart';
import 'package:attendance_app/core/widgets/card/my_card.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/image/cache_image_organization.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';

class CompanyProfileCard extends StatelessWidget {
  const CompanyProfileCard({
    super.key,
    this.companyName,
    this.companyLogo,
    this.companyOwnerImage,
    this.companyOwnerName,
    this.onTapEdit,
  });

  final String? companyName;
  final String? companyLogo;
  final String? companyOwnerImage;
  final String? companyOwnerName;
  final void Function()? onTapEdit;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        //parent container for the background
        MyCard(
          width: size.width,
          height: SizeUtils.scale(160, size.width),
          borderRadius: BorderRadius.circular(0),
          boxShadow: const [],
        ),
        //blue container on the back
        MyCard(
          width: size.width,
          height: SizeUtils.scale(90, size.width),
          borderRadius: BorderRadius.circular(0),
          boxShadow: const [],
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        //front content
        Positioned(
          top: SizeUtils.scale(30, size.width),
          child: MyCard(
            width: size.width,
            height: SizeUtils.scale(130, size.width),
            boxShadow: const [],
            padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.scale(
                AppSize.paddingHorizontalLarge,
                size.width,
              ),
            ),
            borderRadius: BorderRadius.circular(0),
            backgroundColor: Colors.transparent,
            child: MyCard(
              width: size.width,
              padding: EdgeInsets.all(
                SizeUtils.scale(
                  15,
                  size.width,
                ),
              ),
              borderRadius: BorderRadius.circular(
                SizeUtils.scale(14, size.width),
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.outline.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              child: Row(
                children: [
                  MyCacheImageOrganization(
                    imageUrl: companyLogo,
                    width: SizeUtils.scale(100, size.width),
                    height: SizeUtils.scale(100, size.width),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: SizeUtils.scale(2, size.width),
                    ),
                  ),
                  SizedBox(width: SizeUtils.scale(50, size.width)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: SizeUtils.scale(145, size.width),
                        ),
                        child: MyText(
                          text: companyName ?? "Organization Name",
                          style: BodyLargeRegular.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeUtils.scale(6, size.width),
                      ),
                      Row(
                        children: [
                          MyCacheImage(
                            imageUrl: companyOwnerImage,
                            width: SizeUtils.scale(22, size.width),
                            height: SizeUtils.scale(22, size.width),
                          ),
                          SizedBox(
                            width: SizeUtils.scale(5, size.width),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: SizeUtils.scale(120, size.width),
                            ),
                            child: MyText(
                              text: companyOwnerName ?? "Owner Name",
                              style: BodySmallRegular.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeUtils.scale(6, size.width),
                      ),
                      MyButton(
                        title: "Edit",
                        width: SizeUtils.scale(100, size.width),
                        height: SizeUtils.scale(30, size.width),
                        onTap: onTapEdit,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
