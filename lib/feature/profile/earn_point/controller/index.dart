import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:timesync/core/model/earn_point_model.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/profile/earn_point/service/index.dart';

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
}
