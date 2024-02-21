import 'package:get/get.dart';
import 'package:timesync360/core/model/department_model.dart';

class DepartmentDetailController extends GetxController {
  static DepartmentDetailController get to => Get.find();
  final department = Rxn<DepartmentModel>(null);

  @override
  void onInit() {
    super.onInit();
    initArguments();
  }

  void initArguments() {
    final data = Get.arguments;
    department.value = data;
  }
}
