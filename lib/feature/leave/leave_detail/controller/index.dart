import 'package:timesync360/core/model/leave_model.dart';
import 'package:get/get.dart';

class LeaveDetailController extends GetxController {
  static LeaveDetailController get to => Get.find();
  Rx<LeaveModel> leave = LeaveModel().obs;

  @override
  void onInit() {
    super.onInit();
    leave.value = Get.arguments;
  }
}
