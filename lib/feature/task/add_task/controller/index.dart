import 'package:dio/dio.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/constants/svg.dart';
import 'package:timesync/core/model/attachment_model.dart';
import 'package:timesync/core/model/task_model.dart';
import 'package:timesync/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:timesync/core/widgets/color_picker/color_picker_dialog.dart';
import 'package:timesync/core/widgets/icon_picker/icon_picker_dialog.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/feature/task/add_task/model/create_task_model.dart';
import 'package:timesync/feature/task/add_task/service/index.dart';
import 'package:timesync/feature/task/task/controller/index.dart';
import 'package:timesync/feature/task/task/service/index.dart';
import 'package:timesync/notification/notification_schdule.dart';
import 'package:timesync/types/state.dart';
import 'package:timesync/types/task_priority.dart';
import 'package:timesync/types/task_status.dart';
import 'package:timesync/utils/converter.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/utils/upload_file_util.dart';

class AddTaskController extends GetxController {
  final title = "Add Task".obs;
  final task = Rxn<TaskModel>(null);
  final appState = AppState.create.obs;
  final attachments = <AttachmentModel>[].obs;

  final color = Rxn<Color>(null);
  final stringColor = Rxn<String>(null);
  final stringColorLabel = Rxn<String>(null);
  late Color screenPickerColor;
  final stringIcon = Rxn<String>(null);
  final stringIconLabel = Rxn<String>(null);

  final startDate = Rxn<int>(null);
  final endDate = Rxn<int>(null);

  final taskController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();

  final selectPriority = TaskPriority.low.obs;
  final priority = [
    TaskPriority.low,
    TaskPriority.medium,
    TaskPriority.high,
    TaskPriority.urgent
  ];

  final selectStatus = TaskStatus.todo.obs;
  final status = [
    TaskStatus.todo,
    TaskStatus.progress,
    TaskStatus.done,
  ];

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
        final result =
            await UploadFileUtil.uploadFiles(attachments.value, "task");
        attachments.value = result;
        CreateTaskModel input = CreateTaskModel(
          name: taskController.text.trim(),
          description: descriptionController.text,
          startDate: startDate.value,
          endDate: endDate.value,
          color: stringColor.value,
          icon: stringIcon.value,
          status: selectStatus.value,
          priority: selectPriority.value,
          attachment: attachments.value,
          completedDate: selectStatus.value == TaskStatus.done
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
  }

  Future<void> updateTask() async {
    validate();
    if (MyTextFieldFormController.findController('Task').isValid) {
      try {
        final result =
            await UploadFileUtil.uploadFiles(attachments.value, "task");
        attachments.value = result;
        CreateTaskModel input = CreateTaskModel(
          name: taskController.text,
          description: descriptionController.text,
          startDate: startDate.value,
          endDate: endDate.value,
          color: stringColor.value,
          icon: stringIcon.value,
          status: selectStatus.value,
          priority: selectPriority.value,
          attachment: attachments.value,
          completedDate: selectStatus.value == TaskStatus.done
              ? DateTime.now().millisecondsSinceEpoch
              : null,
        );
        await AddTaskService().updateTask(task.value!.id!, input);
        TaskController.to.getUserTasks();
        TaskController.to.setUpTasksNotification(updatedId: task.value!.id);
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
        attachments.value = task.value?.attachment ?? [];
        taskController.text = task.value?.name ?? '';
        selectPriority.value = task.value?.priority ?? TaskPriority.low;
        selectStatus.value = task.value?.status ?? TaskStatus.todo;
        startDateController.text =
            DateUtil.formatMillisecondsToDOB(task.value?.startDate ?? 0);
        endDateController.text =
            DateUtil.formatMillisecondsToDOB(task.value?.endDate ?? 0);
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
        DateUtil.formatMillisecondsToDOB(now.millisecondsSinceEpoch);
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
        if (color.value != null) {
          stringColorLabel.value = ColorTools.nameThatColor(color.value!);
        }
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
          stringIcon.value = value.iconCode;
          stringIconLabel.value = value.iconName;
        },
      ),
    );
  }

  Future<void> deleteTask(String? id) async {
    if (id == null) return;
    try {
      getConfirmBottomSheet(
        Get.context!,
        title: "Delete Task",
        description: "Are you sure to delete this task?",
        onTapConfirm: () async {
          await TaskService().deleteTask(id);
          await NotificationSchedule.cancelSpecificReminder(
              generateUniqueIntId(id));
          await TaskController.to.getUserTasks();
          Navigator.of(Get.context!).popUntil((route) => route.isFirst);
        },
        image: SvgAssets.delete,
      );
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    }
  }
}
