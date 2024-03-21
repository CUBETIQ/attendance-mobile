import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/core/widgets/image/cache_image.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/navigation/model/drawer_model.dart';
import 'package:timesync/types/role.dart';
import 'package:timesync/utils/size_util.dart';
import 'package:timesync/utils/string_util.dart';

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
    final mediaQuery = MediaQuery.of(context);
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeUtils.scale(20, mediaQuery.size.width),
          top: SizeUtils.scale(40, mediaQuery.size.height),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCacheImage(
                  imageUrl: imageUrl ?? "",
                  width: SizeUtils.scale(100, mediaQuery.size.width),
                  height: SizeUtils.scale(100, mediaQuery.size.width),
                  imageHeight: SizeUtils.scale(100, mediaQuery.size.width),
                  imageWidth: SizeUtils.scale(100, mediaQuery.size.width),
                ),
                SizedBox(height: SizeUtils.scale(5, mediaQuery.size.height)),
                Padding(
                  padding: EdgeInsets.only(
                      right: SizeUtils.scale(20, mediaQuery.size.width)),
                  child: MyText(
                    text: StringUtil.getfullname(
                      user.firstName,
                      user.lastName,
                      user.username,
                    ),
                    maxLines: 2,
                    style: AppFonts().bodyLarge.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ),
                MyText(
                  text: (user.role ?? Role.admin).capitalizeFirst,
                  style: AppFonts().bodyMediumRegular.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                SizedBox(height: SizeUtils.scale(10, mediaQuery.size.height)),
                ListView.builder(
                  itemCount: drawerItems.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return ListTile(
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal:
                              SizeUtils.scale(20, mediaQuery.size.width),
                          vertical: SizeUtils.scale(5, mediaQuery.size.width)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          SizeUtils.scale(AppSize().borderRadiusLarge,
                              mediaQuery.size.width),
                        ),
                      ),
                      onTap: () {
                        ZoomDrawer.of(context)?.close();
                        drawerItems[index].onTap!();
                      },
                      leading: Icon(
                        drawerItems[index].icon,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      title: MyText(
                        text: drawerItems[index].title,
                        style: AppFonts().bodyMediumMedium.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Transform.translate(
              offset: Offset(
                  SizeUtils.scale(
                      MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? mediaQuery.size.width / 4.05
                          : mediaQuery.size.width / 5.5,
                      mediaQuery.size.width),
                  -25),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.copyright_rounded,
                      color: Theme.of(context).colorScheme.outline,
                      size: SizeUtils.scale(24, mediaQuery.size.width),
                    ),
                    SizedBox(width: SizeUtils.scale(3, mediaQuery.size.width)),
                    MyText(
                      text: "TimeSync 360 V1.0.0",
                      style: AppFonts().bodyMediumMedium.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
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
