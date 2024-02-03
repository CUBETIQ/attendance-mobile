import 'package:timesync360/core/widgets/button/back_button.dart';
import 'package:timesync360/core/widgets/text/app_bar_title.dart';
import 'package:timesync360/feature/avatar/controller/index.dart';
import 'package:timesync360/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync360/types/avatar_type.dart';

class AvatarViewMobile extends StatelessWidget {
  const AvatarViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AvatarController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Choose Avatar",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: SizeUtils.scale(10, size.height),
          ),
          child: Center(
            child: Obx(
              () => Wrap(
                spacing: SizeUtils.scale(10, size.width),
                runSpacing: SizeUtils.scale(20, size.width),
                children: [
                  ...controller.avatars.map(
                    (e) => GestureDetector(
                      onTap: () => controller.pickImage(e),
                      child: Container(
                        width: SizeUtils.scale(80, size.width),
                        height: SizeUtils.scale(80, size.width),
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                        child: Image.asset(
                          e,
                          width: SizeUtils.scale(
                            controller.avatarType.value == AvatarType.profile
                                ? 75
                                : controller.avatarType.value ==
                                        AvatarType.organization
                                    ? 50
                                    : 60,
                            size.width,
                          ),
                          height: SizeUtils.scale(
                            controller.avatarType.value == AvatarType.profile
                                ? 75
                                : controller.avatarType.value ==
                                        AvatarType.organization
                                    ? 50
                                    : 60,
                            size.width,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
