import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/model/summary_task_model.dart';
import 'package:timesync/core/model/task_model.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/date_picker/month_picker.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/task/task/service/index.dart';
import 'package:timesync/routes/app_pages.dart';

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
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }

  Future<void> getUserSummarizeTask() async {
    clearData();
    try {
      summarizeTasks.value = await TaskService().getUserTaskSummarize(
        startDate: startDate.value,
        endDate: endDate.value,
      );
      if (summarizeTasks.isNotEmpty) {
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
          getUserSummarizeTask();
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
    getUserSummarizeTask();
  }

  void onRefresh() {
    getUserTasks();
    getUserSummarizeTask();
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
      getUserSummarizeTask();
    }
  }
}
