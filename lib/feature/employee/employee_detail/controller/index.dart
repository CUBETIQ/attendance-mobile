import 'package:timesync360/core/model/department_model.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/model/user_model.dart';
import 'package:get/get.dart';

class StaffDetailController extends GetxController {
  final staff = UserModel().obs;
  final position = PositionModel().obs;
  final department = DepartmentModel().obs;

  @override
  void onInit() {
    super.onInit();
    staff.value = Get.arguments['staff'];
    position.value = Get.arguments['position'];
    department.value = Get.arguments['department'];
  }
}
