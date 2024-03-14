import 'package:flutter/material.dart';
import 'package:timesync/constants/app_size.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/onboard/widgets/page.dart';
import 'package:timesync/feature/permission/controller/index.dart';
import 'package:timesync/utils/size_util.dart';

class AppPermissionView extends StatelessWidget {
  const AppPermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppPermissionController.to;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: controller.onChange,
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: controller.onBoardList
                    .map(
                      (e) => MyPage(
                        image: e.image,
                        height: SizeUtils.scale(
                          300,
                          MediaQuery.of(context).size.width,
                        ),
                        width: SizeUtils.scale(
                          300,
                          MediaQuery.of(context).size.width,
                        ),
                        title: e.title,
                        description: e.description,
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: SizeUtils.scale(
                  AppSize().paddingHorizontalLarge,
                  MediaQuery.of(context).size.width,
                ),
                horizontal: SizeUtils.scale(
                  AppSize().paddingHorizontalLarge,
                  MediaQuery.of(context).size.width,
                ),
              ),
              child: Column(
                children: [
                  MyAsyncButton(
                    title: "Allow",
                    onTap: controller.onTapButton,
                  ),
                  TextButton(
                    onPressed: controller.maybeLater,
                    child: MyText(
                      text: 'Maybe later',
                      style: AppFonts().bodyMediumRegular,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
