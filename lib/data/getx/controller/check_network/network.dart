import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cubetiq_attendance_app/components/debounce/debounce.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxController {
  static ConnectivityService get to => Get.find();
  var connectionStatus = 0.obs;
  RxBool hasInternet = false.obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> streamSubscription;

  var init = false.obs;

  final _debouncer = Debouncer(milliseconds: 800);

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException {
      rethrow;
    }
    return updateConnectionStatus(result);
  }

  updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      connectionStatus.value = 0;
      hasInternet.value = false;
      update();
    } else if (ConnectivityResult.ethernet == result ||
        ConnectivityResult.wifi == result ||
        ConnectivityResult.mobile == result ||
        ConnectivityResult.vpn == result) {
      connectionStatus.value = 1;
      hasInternet.value = true;
      _debouncer.run(() {
        if (init.value == true) {
          // showSuccessSnackBar('Yay!', 'Internet Connected!');
        }
        init.value = true;
      });
      update();
    }
  }

  void unSubscript() {
    streamSubscription.cancel();
  }
}
