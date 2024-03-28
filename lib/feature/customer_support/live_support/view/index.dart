import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/core/widgets/button/back_button.dart';
import 'package:timesync/core/widgets/text/app_bar_title.dart';
import 'package:timesync/feature/customer_support/live_support/widget/web_view.dart';
import 'package:timesync/utils/size_util.dart';

class LiveSupportView extends StatelessWidget {
  const LiveSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    late final InAppWebViewController webViewController;
    return Scaffold(
        appBar: AppBar(
          title: const MyAppBarTitle(
            title: 'Live Support',
          ),
          centerTitle: true,
          leading: const MyBackButton(),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: SizeUtils.scale(20, size.width)),
              child: InkWell(
                onTap: () async {
                  await webViewController.reload();
                },
                child: const Icon(Icons.refresh_rounded),
              ),
            ),
          ],
        ),
        body: MyWebView(
          url: AppConfig.liveSupportUrl,
          onWebViewCreated: (controller) {
            webViewController = controller;
            controller.addJavaScriptHandler(
                handlerName: 'showToast',
                callback: (arguments) {
                  final String data = arguments[0];
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(data),
                    duration: const Duration(seconds: 1),
                  ));
                });
          },
        ));
  }
}
