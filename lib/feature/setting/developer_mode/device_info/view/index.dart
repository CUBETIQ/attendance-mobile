import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/feature/setting/developer_mode/device_info/controller/device_info_controller.dart';
import 'package:timesync/utils/size_util.dart';

class DeviceInfoView extends StatelessWidget {
  const DeviceInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DeviceInfoController.to;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(
          title: "Device Info",
        ),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() => InfoWidget(
            map: controller.deviceInfo.value,
          )),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final Map<String, dynamic> map;

  const InfoWidget({
    super.key,
    required this.map,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return map.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: map.keys.map((key) {
              final value = map[key];

              return Container(
                padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.scale(10, size.width)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MyText(
                      text: key,
                      style: AppFonts().bodyMediumRegular,
                    ),
                    SizedBox(width: SizeUtils.scale(20, size.width)),
                    Flexible(
                      child: key == 'fcmtoken' || key == 'userId'
                          ? InkWell(
                              onLongPress: () {
                                Clipboard.setData(ClipboardData(text: '$value'))
                                    .then((value) => showSuccessSnackBar(
                                        key == 'userId'
                                            ? 'userId Copied'
                                            : 'FCM Token Copied',
                                        key == 'userId'
                                            ? 'You have copied the userId'
                                            : 'You have copied the token'));
                              },
                              child: MyText(
                                text: '$value',
                                maxLines: 10,
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts().bodyMediumRegular.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            )
                          : MyText(
                              text: '$value',
                              maxLines: 10,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts().bodyMediumRegular,
                            ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
  }
}
