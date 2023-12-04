import 'package:attendance_app/feature/auth/activation/controller/index.dart';
import 'package:get/get.dart';

class ActivationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivationController>(() => ActivationController());
  }
}
