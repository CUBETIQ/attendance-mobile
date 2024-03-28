import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:timesync/core/widgets/loading/loading.dart';
import 'package:timesync/core/widgets/no_data/no_data.dart';
import 'package:timesync/feature/customer_support/live_support/controller/index.dart';
import 'package:timesync/utils/url_util.dart';

class MyWebView extends StatelessWidget {
  const MyWebView(
      {super.key, required this.url, required this.onWebViewCreated});

  final String url;

  final void Function(InAppWebViewController) onWebViewCreated;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return LiveSupportController.to.isLoading.value == true
              ? const Center(child: MyLoading())
              : const SizedBox();
        }),
        Obx(() {
          return LiveSupportController.to.isError.value == false
              ? InAppWebView(
                  keepAlive: InAppWebViewKeepAlive(),
                  initialUrlRequest: URLRequest(
                    url: WebUri(urlRefactoring(url)),
                  ),
                  onWebViewCreated: onWebViewCreated,
                  onLoadStart: (controller, url) {
                    LiveSupportController.to.isLoading.value = true;
                  },
                  onLoadStop: (controller, url) async {
                    await Future.delayed(const Duration(milliseconds: 100), () {
                      LiveSupportController.to.isLoading.value = false;
                    });
                  },
                  onReceivedError: (controller, request, error) async {
                    LiveSupportController.to.isError.value = true;
                    await Future.delayed(const Duration(milliseconds: 100), () {
                      LiveSupportController.to.isLoading.value = false;
                    });
                  },
                  onReceivedHttpError:
                      (controller, request, errorResponse) async {
                    await Future.delayed(const Duration(milliseconds: 100), () {
                      LiveSupportController.to.isLoading.value = false;
                    });
                  },
                )
              : const MyNoData();
        }),
        Obx(() {
          return LiveSupportController.to.isLoading.value == true
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.background,
                  child: const Center(child: MyLoading()))
              : const SizedBox();
        }),
      ],
    );
  }
}
