import 'package:attendance_app/core/widgets/console/console.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  static TaskController get to => Get.find();

  void onTapAddTask() {
    Console.log("Tap", "Add Task");
  }
}
