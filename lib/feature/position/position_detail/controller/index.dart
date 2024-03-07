import 'package:get/get.dart';
import 'package:timesync/core/model/position_model.dart';

class PositionDetailController extends GetxController {
  static PositionDetailController get to => Get.find();
  final position = Rxn<PositionModel>(null);

  @override
  void onInit() {
    super.onInit();
    initArguments();
  }

  void initArguments() {
    final data = Get.arguments;
    position.value = data;
  }
}
