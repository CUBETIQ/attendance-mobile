import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/customer_support/live_support/controller/index.dart';
import 'package:timesync/feature/customer_support/live_support/widget/web_view.dart';
import 'package:timesync/utils/size_util.dart';

class LiveSupportView extends StatelessWidget {
  const LiveSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    late final InAppWebViewController webViewController;
    final controller = Get.find<LiveSupportController>();
    return Obx(() {
      return Scaffold(
          appBar: controller.isError.value == true
              ? AppBar(
                  title: const MyAppBarTitle(
                    title: 'Live Support',
                  ),
                  centerTitle: true,
                  leading: const MyBackButton(),
                  automaticallyImplyLeading: false,
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeUtils.scale(20, size.width)),
                      child: InkWell(
                        onTap: () async {
                          await webViewController.reload();
                        },
                        child: const Icon(Icons.refresh_rounded),
                      ),
                    ),
                  ],
                )
              : null,
          body: SafeArea(
            child: MyWebView(
              url: AppConfig.liveSupportUrl,
              onWebViewCreated: (controller) {
                webViewController = controller;
                controller.addJavaScriptHandler(
                    handlerName: 'onBack',
                    callback: (arguments) {
                      final String data = arguments[0];
                      if (data == 'true') {
                        Get.back();
                      }
                    });
              },
            ),
          ));
    });
  }
}
