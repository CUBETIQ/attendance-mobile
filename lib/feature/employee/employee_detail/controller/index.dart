import 'package:attendance_app/core/model/department_model.dart';
import 'package:attendance_app/core/model/position_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:get/get.dart';

class StaffDetailController extends GetxController {
  Rx<UserModel> staff = UserModel().obs;
  Rx<PositionModel> position = PositionModel().obs;
  Rx<DepartmentModel> department = DepartmentModel().obs;

  @override
  void onInit() {
    super.onInit();
    staff.value = Get.arguments['staff'];
    position.value = Get.arguments['position'];
    department.value = Get.arguments['department'];
  }
}
