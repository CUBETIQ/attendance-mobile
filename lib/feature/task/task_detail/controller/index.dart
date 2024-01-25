import 'package:attendance_app/core/model/task_model.dart';
import 'package:get/get.dart';

class TaskDetailController extends GetxController {
  static TaskDetailController get to => Get.find();
  Rxn<TaskModel> task = Rxn<TaskModel>(null);

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  void getArgument() {
    task.value = Get.arguments["task"];
  }
}
