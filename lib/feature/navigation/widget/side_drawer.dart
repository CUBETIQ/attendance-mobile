import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/navigation/model/drawer_model.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';
import 'package:timesync/types/role.dart';
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
          left: SizeUtils.scaleMobile(20, size.width),
          top: SizeUtils.scaleMobile(40, size.height),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCacheImage(
              imageUrl: imageUrl ?? "",
              width: SizeUtils.scaleMobile(100, size.width),
              height: SizeUtils.scaleMobile(100, size.width),
              imageHeight: SizeUtils.scaleMobile(100, size.width),
              imageWidth: SizeUtils.scaleMobile(100, size.width),
            ),
            SizedBox(height: SizeUtils.scaleMobile(5, size.height)),
            MyText(
              text: StringUtil.getfullname(
                user.firstName,
                user.lastName,
                user.username,
              ),
              style: AppFonts().bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            MyText(
              text: (user.role ?? Role.admin).capitalizeFirst,
              style: AppFonts().bodyMediumRegular.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            SizedBox(height: SizeUtils.scaleMobile(10, size.height)),
            ...List.generate(
              drawerItems.length,
              (index) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.scaleMobile(20, size.width)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    SizeUtils.scaleMobile(
                        AppSize().borderRadiusLarge, size.width),
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
                  style: AppFonts().bodyMediumMedium.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
            ),
            const Spacer(),
            Transform.translate(
              offset: Offset(SizeUtils.scaleMobile(70, size.width), 0),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: SizeUtils.scaleMobile(20, size.height),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.copyright_rounded,
                        color: Theme.of(context).colorScheme.secondary,
                        size: SizeUtils.scaleMobile(24, size.width),
                      ),
                      SizedBox(width: SizeUtils.scaleMobile(3, size.width)),
                      MyText(
                        text: "TimeSync 360 V1.0.0",
                        style: AppFonts().bodyMediumMedium.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
