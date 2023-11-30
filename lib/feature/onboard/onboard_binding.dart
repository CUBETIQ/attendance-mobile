import 'package:attendance_app/feature/onboard/controller/index.dart';
import 'package:get/get.dart';

class OnBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardController>(() => OnBoardController());
  }
}
