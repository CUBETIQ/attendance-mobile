import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/position/position/service/index.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PositionController extends GetxController {
  static PositionController get to => Get.find();
  RxList<PositionModel> positionList = <PositionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllPositions();
  }

  Future<void> getAllPositions() async {
    try {
      positionList.value = await PositionService().getAllPosition(
          organizationId: NavigationController.to.organization.value.id ?? "");
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }
}
