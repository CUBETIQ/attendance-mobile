import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/image/cache_image.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/navigation/model/drawer_model.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:attendance_app/utils/string_util.dart';
import 'package:attendance_app/utils/types_helper/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class SideDrawer extends StatelessWidget {
  final String? imageUrl;
  final String? userRole;
  final List<DrawerModel> drawerItems;
  final UserModel user;

  const SideDrawer({
    super.key,
    this.imageUrl,
    this.userRole,
    required this.drawerItems,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(20, size.width),
          top: SizeUtils.scale(40, size.height),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCacheImage(
              imageUrl: imageUrl ?? "",
              width: SizeUtils.scale(100, size.width),
              height: SizeUtils.scale(100, size.width),
              imageHeight: SizeUtils.scale(100, size.width),
              imageWidth: SizeUtils.scale(100, size.width),
            ),
            SizedBox(height: SizeUtils.scale(5, size.height)),
            MyText(
              text: StringUtil().getfullname(
                user.firstName,
                user.lastName,
                user.username,
              ),
              style: BodyLarge.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            MyText(
              text: (user.role ?? Role.admin).capitalizeFirst,
              style: BodyMediumRegular.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(height: SizeUtils.scale(10, size.height)),
            ...List.generate(
              drawerItems.length,
              (index) => SizedBox(
                height: SizeUtils.scale(22, size.height),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      SizeUtils.scale(AppSize.borderRadiusLarge, size.width),
                    ),
                  ),
                  onTap: () {
                    ZoomDrawer.of(context)?.close();
                    drawerItems[index].onTap!();
                  },
                  leading: Icon(
                    drawerItems[index].icon,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: MyText(
                    text: drawerItems[index].title,
                    style: BodyMediumMedium.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeUtils.scale(20, size.height),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.copyright_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                    size: SizeUtils.scale(24, size.width),
                  ),
                  SizedBox(width: SizeUtils.scale(3, size.width)),
                  MyText(
                    text: "TimeSync 360 V1.0.0",
                    style: BodyMediumMedium.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
