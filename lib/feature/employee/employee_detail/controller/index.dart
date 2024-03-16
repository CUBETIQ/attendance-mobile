import 'package:timesync/core/model/department_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:get/get.dart';

class StaffDetailController extends GetxController {
  final staff = UserModel().obs;
  final position = Rxn<PositionModel>(null);
  final department = Rxn<DepartmentModel>(null);

  @override
  void onInit() {
    super.onInit();
    staff.value = Get.arguments['staff'];
    position.value = Get.arguments['position'];
    department.value = Get.arguments['department'];
  }
}
