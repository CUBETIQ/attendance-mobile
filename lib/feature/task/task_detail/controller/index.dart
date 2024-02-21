import 'package:timesync360/core/model/task_model.dart';
import 'package:get/get.dart';

class TaskDetailController extends GetxController {
  static TaskDetailController get to => Get.find();
  final task = Rxn<TaskModel>(null);

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  void getArgument() {
    task.value = Get.arguments["task"];
  }
}
