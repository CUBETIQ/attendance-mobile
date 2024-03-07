import 'package:flutter/material.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/model/summary_task_model.dart';
import 'package:timesync/core/model/task_model.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/date_picker/month_picker.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/feature/task/task/service/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/state.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

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

  Future<void> getUserSummarizeLeave() async {
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
            "state": AppState.edit,
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
    }
  }
}
