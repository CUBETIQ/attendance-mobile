import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/button/async_button.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/feature/setting/developer_mode/storage_management/controller/storage_management_controller.dart';
import 'package:timesync/utils/size_util.dart';

class StorageManagementView extends StatelessWidget {
  const StorageManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = StorageManagementController.to;

    return Scaffold(
        appBar: AppBar(
          title: const MyAppBarTitle(
            title: "Storage Mangaement",
          ),
          centerTitle: true,
          leading: const MyBackButton(),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return buildCacheBlock(
                title: 'Cache Usage',
                value: controller.localCache.value,
                onTap: () => controller.onTapClearCached(),
              );
            }),
            Obx(() {
              return buildCacheBlock(
                title: 'User Data',
                value: controller.userData.value,
                onTap: () => controller.onTapClearUserData(),
              );
            }),
            Obx(() {
              return buildCacheBlock(
                title: 'Reset App',
                value: '',
                onTap: () => controller.onTapResetApp(),
              );
            }),
          ],
        ));
  }
}

Widget buildCacheBlock(
    {required String? title,
    required String? value,
    required Future<void> Function()? onTap}) {
  final size = MediaQuery.of(Get.context!).size;
  return Padding(
    padding: EdgeInsets.only(
        left: SizeUtils.scale(15, size.width),
        right: SizeUtils.scale(15, size.width),
        top: SizeUtils.scale(15, size.width)),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(Get.context!).colorScheme.shadow.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        color: Theme.of(Get.context!).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: EdgeInsets.symmetric(
          vertical: SizeUtils.scale(15, size.width),
          horizontal: SizeUtils.scale(15, size.width)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                        text: title ?? '',
                        textAlign: TextAlign.start,
                        style: AppFonts().bodyMediumRegular),
                    value == ''
                        ? const SizedBox.shrink()
                        : MyText(
                            text: value ?? '',
                            style: AppFonts().bodyMediumRegular),
                  ],
                ),
              ),
              SizedBox(width: SizeUtils.scale(20, size.width)),
              SizedBox(
                  height: 40,
                  width: 80,
                  child: MyAsyncButton(
                    onTap: onTap ?? () async {},
                    title: title == 'Reset App'
                        ? 'Reset'.trString
                        : 'Clear'.trString,
                    backgroundColor: Theme.of(Get.context!).colorScheme.error,
                  )),
            ],
          ),
        ],
      ),
    ),
  );
}
