import 'package:get/get.dart';
import 'package:timesync/feature/home/home/controller/index.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/role.dart';
import 'package:timesync/utils/logger.dart';

class QRService {
  static final _singleton = QRService._internal();

  factory QRService() {
    return _singleton;
  }

  QRService._internal() {
    Logs.t('[QRService] Initialized');
  }

  final deepLinkUrl = Rxn<String>(null);

  Future<void> initDeepLink() async {
    if (Get.isRegistered<NavigationController>()) {
      // Get.until((route) => Get.currentRoute == Routes.NAVIGATION);
      Get.offNamed(Routes.NAVIGATION);

      if (NavigationController.to.selectedIndex.value != 0) {
        NavigationController.to.selectedIndex.value = 0;
      }
      if (NavigationController.to.getUserRole.value == Role.admin) {
        HomeController.to.tabController?.animateTo(1);
      }
      HomeController.to.isCheckedIn.value == true
          ? HomeController.to.checkOut()
          : HomeController.to.checkIn();
    }
  }
}
