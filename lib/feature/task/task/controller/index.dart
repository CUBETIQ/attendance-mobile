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
import 'package:timesync/feature/task/task/service/index.dart';
import 'package:timesync/notification/notification_schdule.dart';
import 'package:timesync/notification/notification_service.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/task_status.dart';
import 'package:timesync/utils/converter.dart';

class TaskController extends GetxController {
  static TaskController get to => Get.find();
  final tasks = <TaskModel>[].obs;
  final totalTask = 0.obs;
  final totalCompletedTask = 0.obs;
  final totalUncompletedTask = 0.obs;
  final percentageCompletedTask = 0.0.obs;
  final percentageUncompletedTask = 0.0.obs;
  final summarizeTasks = <SummaryTaskModel>[].obs;
  final startDate = Rxn<int>();
  final endDate = Rxn<int>();
  final selectDate = DateTime.now().obs;

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
      calculateTaskSummary();
      tasks.value
          .sort((a, b) => (b.startDate ?? 0).compareTo(a.startDate ?? 0));
      tasks.value.sort((a, b) => (b.status ?? "").compareTo(a.status ?? ""));

      // Set notification for task reminder
      final List<int> notificationIds =
          await NotificationIntegration.getPendingNotificationId();

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
    totalUncompletedTask.value = 0;
    percentageCompletedTask.value = 0;
    percentageUncompletedTask.value = 0;
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
    totalTask.value = tasks.value.length;
    totalCompletedTask.value = tasks.value
        .where((element) => element.status == TaskStatus.done)
        .length;
    totalUncompletedTask.value = totalTask.value - totalCompletedTask.value;
    percentageCompletedTask.value =
        totalTask.value == 0 ? 0 : totalCompletedTask.value / totalTask.value;
    percentageUncompletedTask.value = 1 - percentageCompletedTask.value;
  }
}
