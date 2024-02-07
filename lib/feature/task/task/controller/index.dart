import 'package:timesync360/constants/svg.dart';
import 'package:timesync360/core/model/summary_task_model.dart';
import 'package:timesync360/core/model/task_model.dart';
import 'package:timesync360/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/feature/task/task/service/index.dart';
import 'package:timesync360/routes/app_pages.dart';
import 'package:timesync360/types/state.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  static TaskController get to => Get.find();
  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  final RxInt totalTask = 0.obs;
  final RxInt totalCompletedTask = 0.obs;
  final RxInt totalUncompletedTask = 0.obs;
  final RxDouble percentageCompletedTask = 0.0.obs;
  final RxDouble percentageUncompletedTask = 0.0.obs;
  final RxList<SummaryTaskModel> summarizeTasks = <SummaryTaskModel>[].obs;
  final Rxn<int> startDate = Rxn<int>();
  final Rxn<int> endDate = Rxn<int>();

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
      totalTask.value = summarizeTasks.value.last.totalTask ?? 0;
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
        image: SvgAssets.checkIn,
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
        image: SvgAssets.delete,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  void onTapTask(TaskModel task) {
    getEditDeleteViewBottomSheet(
      Get.context!,
      image: SvgAssets.option,
      onTapView: () {
        Get.back();
        Get.toNamed(
          Routes.TASK_DETAIL,
          arguments: {
            "task": task,
          },
        );
      },
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

  void onTapCompleteTask(TaskModel task) {
    Get.toNamed(
      Routes.TASK_DETAIL,
      arguments: {
        "task": task,
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
