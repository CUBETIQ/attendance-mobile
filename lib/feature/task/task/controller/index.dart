import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/model/task_model.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/task/task/service/index.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:attendance_app/utils/types_helper/state.dart';
import 'package:attendance_app/utils/types_helper/task_status.dart';
import 'package:dio/dio.dart';
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
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> completeTask(String id) async {
    try {
      getConfirmBottomSheet(
        Get.context!,
        title: "Complete Task",
        description: "Are you sure to complete this task?",
        onTapConfirm: () async {
          await TaskService().completeTask(id);
          getOwnTasks();
          Get.back();
        },
        image: checkIn,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> onRefresh() async {
    await getOwnTasks();
  }

  Future<void> deleteTask(String id) async {
    try {
      getConfirmBottomSheet(
        Get.context!,
        title: "Delete Task",
        description: "Are you sure to delete this task?",
        onTapConfirm: () async {
          await TaskService().deleteTask(id);
          getOwnTasks();
          Get.back();
        },
        image: delete,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void onTapTask(TaskModel task) {
    getOptionBottomSheet(
      Get.context!,
      image: option,
      onTapEdit: () {
        Get.back();
        Get.toNamed(
          Routes.ADD_TASK,
          arguments: {
            "state": AppState.Edit,
            "task": task,
          },
        );
      },
      onTapDelete: () {
        Get.back();
        deleteTask(task.id!);
      },
    );
  }
}
