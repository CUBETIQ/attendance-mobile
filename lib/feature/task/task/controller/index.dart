import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/config/app_config.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/model/summary_task_model.dart';
import 'package:timesync/core/model/task_model.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/date_picker/month_picker.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/task/add_task/model/create_task_model.dart';
import 'package:timesync/feature/task/add_task/service/index.dart';
import 'package:timesync/feature/task/task/service/index.dart';
import 'package:timesync/notification/notification_schdule.dart';
import 'package:timesync/notification/notification_service.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/task.dart';
import 'package:timesync/utils/converter.dart';

class TaskController extends GetxController {
  static TaskController get to => Get.find();
  final tasks = <TaskModel>[].obs;
  final allTasksNoComplete = <TaskModel>[].obs;
  final pendingTasks = <TaskModel>[].obs;
  final completedTasks = <TaskModel>[].obs;

  final totalTask = 0.obs;
  final totalCompletedTask = 0.obs;
  final totalTodoTask = 0.obs;
  final totalProgressTask = 0.obs;
  final percentageCompletedTask = 0.0.obs;
  final percentageTodoTask = 0.0.obs;
  final percentageProgressTask = 0.0.obs;
  final summarizeTasks = <SummaryTaskModel>[].obs;
  final startDate = Rxn<int>();
  final endDate = Rxn<int>();
  final selectDate = DateTime.now().obs;
  final haveNoData = false.obs;

  final selectedTaskType = TaskFilter.all.obs;
  final taskType =
      <String>[TaskFilter.all, TaskFilter.pending, TaskFilter.completed].obs;

  @override
  void onInit() {
    super.onInit();
    initFunction();
  }

  Future<void> onAddTask(
      {DateTimeRange? dateTimeRange,
      TextEditingController? descriptionController,
      bool? isUrgent,
      String? selectedStatus,
      TextEditingController? taskController}) async {
    final status = selectedStatus == TaskFilter.completed
        ? TaskStatus.done
        : TaskStatus.progress;
    final priority = isUrgent == true ? TaskPriority.urgent : TaskPriority.low;

    try {
      CreateTaskModel input = CreateTaskModel(
        name: taskController?.text.trim(),
        description: descriptionController?.text,
        startDate: dateTimeRange?.start.millisecondsSinceEpoch ??
            DateTime.now().millisecondsSinceEpoch,
        endDate: dateTimeRange?.end.millisecondsSinceEpoch,
        status: status,
        priority: priority,
        completedDate: status == TaskStatus.done
            ? DateTime.now().millisecondsSinceEpoch
            : null,
      );
      await AddTaskService().addTask(input);
      TaskController.to.getUserTasks();
      Get.back();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response!.data["message"]);
      rethrow;
    }
  }

  Future<void> getUserTasks() async {
    try {
      tasks.value = await TaskService().getUserTasks(
        startDate: startDate.value,
        endDate: endDate.value,
      );
      calculateTaskSummary();
      tasks.value
          .sort((a, b) => (b.startDate ?? 0).compareTo(a.startDate ?? 0));
      tasks.value.sort((a, b) => (b.status ?? "").compareTo(a.status ?? ""));

      pendingTasks.value = tasks.value
          .where((element) => element.status == TaskStatus.progress)
          .toList();
      completedTasks.value = tasks.value
          .where((element) => element.status == TaskStatus.done)
          .toList();
      allTasksNoComplete.value = tasks.value
          .where((element) => element.status != TaskStatus.done)
          .toList();

      // Set notification for task reminder
      await setUpTasksNotification();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> setUpTasksNotification({String? updatedId}) async {
    final List<int> notificationIds =
        await NotificationIntegration.getPendingNotificationId();

    if (updatedId != null && notificationIds.isNotEmpty) {
      int? uniqueId = generateUniqueIntId(updatedId);
      await NotificationSchedule.cancelSpecificReminder(uniqueId);
    }
    tasks.value
        .where((element) => element.status != TaskStatus.done)
        .forEach((element) {
      if (element.endDate != null) {
        DateTime time = DateTime.fromMillisecondsSinceEpoch(element.endDate!);
        int? uniqueId = generateUniqueIntId(element.id ?? "");

        if (!notificationIds.contains(uniqueId)) {
          if (time.isAfter(AppConfig.currentTime)) {
            NotificationSchedule.taskReminder(
                id: uniqueId, time: element.endDate, mongoId: element.id);
          }
        }
      }
    });
  }

  Future<void> completeTask(String id) async {
    try {
      getConfirmBottomSheet(
        Get.context!,
        title: "Complete Task",
        description: "Are you sure to complete this task?",
        onTapConfirm: () async {
          await TaskService().completeTask(id);
          await NotificationSchedule.cancelSpecificReminder(
              generateUniqueIntId(id));
          await getUserTasks();
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
    initDate();
    getUserTasks();
  }

  void onRefresh() {
    getUserTasks();
  }

  void onChangedTaskType(String? value) {
    if (selectedTaskType.value != value) {
      selectedTaskType.value = value!;
    }
  }

  void onTapTask(TaskModel task) {
    Get.toNamed(
      Routes.TASK_DETAIL,
      arguments: {
        "task": task,
        "user": null,
      },
    );
  }

  void initDate() {
    DateTime now = DateTime.now();
    startDate.value = DateTime(now.year, now.month, 1).millisecondsSinceEpoch;
    endDate.value = DateTime(now.year, now.month + 1, 0).millisecondsSinceEpoch;
  }

  void clearData() {
    totalTask.value = 0;
    totalCompletedTask.value = 0;
    totalTodoTask.value = 0;
    totalProgressTask.value = 0;
    percentageCompletedTask.value = 0;
    percentageTodoTask.value = 0;
    percentageProgressTask.value = 0;
    haveNoData.value = true;
  }

  Future<void> onTapDate(BuildContext context) async {
    final DateTime? picked = await monthPicker(
      context: context,
      initialDate: selectDate.value,
    );
    if (picked != null) {
      selectDate.value = picked;
      startDate.value =
          DateTime(picked.year, picked.month, 1).millisecondsSinceEpoch;
      endDate.value =
          DateTime(picked.year, picked.month + 1, 0).millisecondsSinceEpoch;
      getUserTasks();
    }
  }

  void calculateTaskSummary() {
    if (tasks.value.isNotEmpty) {
      haveNoData.value = false;
      totalTask.value = tasks.value.length;
      totalCompletedTask.value = tasks.value
          .where((element) => element.status == TaskStatus.done)
          .length;
      totalTodoTask.value = tasks.value
          .where((element) =>
              element.status == TaskStatus.todo ||
              element.status == TaskStatus.progress)
          .length;
      totalProgressTask.value = tasks.value
          .where((element) => element.status == TaskStatus.progress)
          .length;
      percentageCompletedTask.value =
          (totalCompletedTask.value / totalTask.value) * 100;
      percentageTodoTask.value = (totalTodoTask.value / totalTask.value) * 100;
      percentageProgressTask.value =
          (totalProgressTask.value / totalTask.value) * 100;
    } else {
      clearData();
    }
  }
}
