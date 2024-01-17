import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/model/summary_task_model.dart';
import 'package:attendance_app/core/model/task_model.dart';
import 'package:attendance_app/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/task/task/service/index.dart';
import 'package:attendance_app/routes/app_pages.dart';
import 'package:attendance_app/utils/types_helper/state.dart';
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
  RxList<SummaryTaskModel> summarizeTasks = <SummaryTaskModel>[].obs;
  Rxn<int> startDate = Rxn<int>();
  Rxn<int> endDate = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    initFunction();
  }

  Future<void> getUserTasks() async {
    try {
      tasks.value = await TaskService().getUserTasks(
        startDate: startDate.value,
        endDate: endDate.value,
      );
      totalTask.value = tasks.length;
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getUserSummarizeLeave() async {
    clearData();
    try {
      summarizeTasks.value = await TaskService().getUserTaskSummarize(
        startDate: startDate.value,
        endDate: endDate.value,
      );
      for (var element in summarizeTasks) {
        totalCompletedTask.value += element.totalTaskDone!;
        totalUncompletedTask.value += element.totalTaskNotDone!;
      }
      if (totalCompletedTask.value != 0) {
        percentageCompletedTask.value =
            (totalCompletedTask.value / totalTask.value * 100) / 100;
      }
      if (totalUncompletedTask.value != 0) {
        percentageUncompletedTask.value =
            (totalUncompletedTask.value / totalTask.value * 100) / 100;
      }
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
          await getUserTasks();
          getUserSummarizeLeave();
          Get.back();
        },
        image: checkIn,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> initFunction() async {
    // initDate();
    await getUserTasks();
    getUserSummarizeLeave();
  }

  void onRefresh() {
    initFunction();
  }

  Future<void> deleteTask(String id) async {
    try {
      getConfirmBottomSheet(
        Get.context!,
        title: "Delete Task",
        description: "Are you sure to delete this task?",
        onTapConfirm: () async {
          await TaskService().deleteTask(id);
          await getUserTasks();
          getUserSummarizeLeave();
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
    getEditAndDeleteBottomSheet(
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

  void initDate() {
    DateTime now = DateTime.now();
    startDate.value = DateTime(now.year, now.month, 1).millisecondsSinceEpoch;
    endDate.value = DateTime(now.year, now.month + 1, 0).millisecondsSinceEpoch;
  }

  void clearData() {
    totalCompletedTask.value = 0;
    totalUncompletedTask.value = 0;
    percentageCompletedTask.value = 0;
    percentageUncompletedTask.value = 0;
  }
}
