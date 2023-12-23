import 'package:get/get.dart';
import 'controller/index.dart';

class LeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveController>(() => LeaveController());
  }
}
