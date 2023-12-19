import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/model/task_model.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/console/console.dart';
import 'package:attendance_app/feature/task/task/service/index.dart';
import 'package:attendance_app/utils/types_helper/task_status.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  static TaskController get to => Get.find();
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxInt totalTask = 0.obs;
  RxInt totalCompletedTask = 0.obs;
  RxInt totalUncompletedTask = 0.obs;
  RxDouble percentageCompletedTask = 0.0.obs;
  RxDouble percentageUncompletedTask = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getOwnTasks();
  }

  Future<void> getOwnTasks() async {
    try {
      tasks.value = await TaskService().getUserTasks();
      totalTask.value = tasks.length;
      totalCompletedTask.value = tasks
          .where((element) => element.taskStatus == TaskStatus.completed)
          .length;
      totalUncompletedTask.value = tasks.length - totalCompletedTask.value;
      percentageCompletedTask.value =
          (totalCompletedTask.value / totalTask.value * 100) / 100;
      percentageUncompletedTask.value = 1 - percentageCompletedTask.value;
    } catch (e) {
      Console.log("Error", e.toString());
    }
  }

  Future<void> completeTask(String id) async {
    try {
      getConfirmBottomSheet(
        Get.context!,
        title: "Complete Task",
        description: "Are you sure to complete this task?",
        onTapLogOut: () async {
          await TaskService().completeTask(id);
          getOwnTasks();
          Get.back();
        },
        image: checkIn,
      );
    } catch (e) {
      Console.log("Error", e.toString());
    }
  }

  void onTapAddTask() {
    Console.log("Tap", "Add Task");
  }
}