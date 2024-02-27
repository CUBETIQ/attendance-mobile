import 'package:timesync360/core/model/task_model.dart';
import 'package:timesync360/core/widgets/color_picker/color_picker_dialog.dart';
import 'package:timesync360/core/widgets/icon_picker/icon_picker_dialog.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync360/extensions/string.dart';
import 'package:timesync360/feature/task/add_task/model/create_task_model.dart';
import 'package:timesync360/feature/task/add_task/service/index.dart';
import 'package:timesync360/feature/task/task/controller/index.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:timesync360/types/state.dart';
import 'package:timesync360/types/task_priority.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskController extends GetxController {
  final title = "Add Task".obs;
  final startDate = Rxn<int>(null);
  final endDate = Rxn<int>(null);
  final taskController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();
  final color = Rxn<Color>(null);
  final stringColor = Rxn<String>(null);
  final stringIcon = Rxn<String>(null);
  final appState = AppState.create.obs;
  final task = Rxn<TaskModel>(null);
  final priority = [
    TaskPriority.low,
    TaskPriority.medium,
    TaskPriority.high,
  ].obs;
  final selectPriority = TaskPriority.low.obs;
  late Color screenPickerColor;

  @override
  void onInit() {
    super.onInit();
    initDate();
    getArgument();
  }

  Future<void> addTask() async {
    validate();
    if (MyTextFieldFormController.findController('Task').isValid) {
      try {
        CreateTaskModel input = CreateTaskModel(
          name: taskController.text,
          description: descriptionController.text,
          startDate: startDate.value,
          endDate: endDate.value,
          color: stringColor.value,
          icon: stringIcon.value,
          priority: selectPriority.value,
        );
        await AddTaskService().addTask(input);
        TaskController.to.getUserTasks();
        TaskController.to.getUserSummarizeLeave();
        Get.back();
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response!.data["message"]);
        rethrow;
      }
    }
  }

  Future<void> updateTask() async {
    validate();

    if (MyTextFieldFormController.findController('Task').isValid) {
      try {
        CreateTaskModel input = CreateTaskModel(
          name: taskController.text,
          description: descriptionController.text,
          startDate: startDate.value,
          endDate: endDate.value,
          color: stringColor.value,
          icon: stringIcon.value,
          priority: selectPriority.value,
        );
        await AddTaskService().updateTask(task.value!.id!, input);
        TaskController.to.getUserTasks();
        Get.back();
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response!.data["message"]);
        rethrow;
      }
    }
  }

  void validate() {
    MyTextFieldFormController.findController('Task').isValid;
  }

  void getArgument() {
    if (Get.arguments != null) {
      if (Get.arguments["state"] == AppState.edit) {
        title.value = "Edit Task";
        appState.value = AppState.edit;
        task.value = Get.arguments["task"];
        taskController.text = task.value?.name ?? '';
        selectPriority.value = task.value?.priority ?? TaskPriority.low;
        startDateController.text =
            DateFormatter.formatMillisecondsToDOB(task.value?.startDate ?? 0);
        endDateController.text =
            DateFormatter.formatMillisecondsToDOB(task.value?.endDate ?? 0);
        startDate.value = task.value?.startDate ?? 0;
        endDate.value = task.value?.endDate ?? 0;
        descriptionController.text = task.value?.description ?? '';
        stringColor.value = task.value?.color;
        stringIcon.value = task.value?.icon;
        if (task.value?.color != null) {
          color.value = Color(task.value!.color!.toInt());
        }
      } else {
        title.value = "Add Task";
        appState.value = AppState.create;
      }
    }
  }

  void initDate() {
    DateTime now = DateTime.now();
    startDateController.text =
        DateFormatter.formatMillisecondsToDOB(now.millisecondsSinceEpoch);
    startDate.value = now.millisecondsSinceEpoch;
  }

  void getStartDateInMilliSecond(int? date) {
    startDate.value = date;
  }

  void getEndDateInMilliSecond(int? date) {
    endDate.value = date;
  }

  void onTapPickColor(BuildContext context) {
    screenPickerColor = Colors.blue;
    getColorPickerDialog(
      context: context,
      screenPickerColor: screenPickerColor,
      onChangeResult: (colorString, value) {
        stringColor.value = colorString;
        color.value = value;
      },
      onCancel: () {
        String? colorString = Theme.of(context).colorScheme.primary.toString();
        RegExp regExp = RegExp(r'0x([0-9a-fA-F]+)');
        Match? match = regExp.firstMatch(colorString);
        color.value = Theme.of(context).colorScheme.primary;
        stringColor.value = match?.group(0) ?? '';
        Get.back();
      },
      onConfirm: () {
        Get.back();
      },
    );
  }

  void onTapPickIcon(BuildContext context) {
    Get.dialog(
      IconPicker(
        onChangeResult: (value) {
          stringIcon.value = value;
        },
      ),
    );
  }
}
