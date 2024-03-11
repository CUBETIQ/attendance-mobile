import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:timesync/core/model/earn_point_model.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/home/home/controller/index.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/profile/earn_point/service/index.dart';
import 'package:timesync/types/role.dart';

class EarnPointController extends GetxController {
  static EarnPointController get to => Get.find();
  final point = EarnPointModel().obs;

  @override
  void onInit() {
    super.onInit();
    getEarnPoint();
  }

  Future<void> getEarnPoint() async {
    try {
      point.value = await EarnPointService().getEarnPoint();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void onTapCheckIn() {
    Get.back();
    NavigationController.to.selectedIndex.value = 0;
    if (NavigationController.to.getUserRole.value != Role.staff) {
      HomeController.to.tabController?.animateTo(1);
    }
  }

  void onTapTask() {
    Get.back();
    NavigationController.to.selectedIndex.value = 2;
  }
}
