import 'package:timesync/core/model/attachment_model.dart';
import 'package:timesync/core/model/leave_model.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/feature/leave/add_leave/model/create_leave_model.dart';
import 'package:timesync/feature/leave/add_leave/model/update_leave_model.dart';
import 'package:timesync/feature/leave/add_leave/service/index.dart';
import 'package:timesync/feature/leave/leave/controller/index.dart';
import 'package:timesync/utils/date_util.dart';
import 'package:timesync/types/leave_duration_type.dart';
import 'package:timesync/types/leave_type.dart';
import 'package:timesync/types/state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/utils/upload_file_util.dart';

class AddLeaveController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AddLeaveController get to => Get.find();
  final title = "Add Leave".obs;
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final reasonController = TextEditingController();
  final durationController = TextEditingController().obs;
  final startDate = Rxn<int>(null);
  final endDate = Rxn<int>(null);
  final selectLeaveType = LeaveType.annual.obs;
  final leaveTypes = [
    LeaveType.annual,
    LeaveType.sick,
  ].obs;
  final selectLeaveDurationType = LeaveTypeDuration.fullDay.obs;
  late AnimationController animationController;
  late Animation<double> sizeAnimation;
  late Animation<Color?> colorAnimation;
  final appState = AppState.create.obs;
  final leave = Rxn<LeaveModel>(null);
  final List<String> duration =
      List.generate(7, (index) => ((index + 1) * 0.5).toString());
  final selectedValue = Rxn<String>(null);
  final searchController = TextEditingController();
  FocusNode? durationFocusNode = FocusNode();
  final attachments = <AttachmentModel>[].obs;

  @override
  void onInit() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    sizeAnimation =
        Tween<double>(begin: 0, end: 1).animate(animationController);
    colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Theme.of(Get.context!).colorScheme.primary,
    ).animate(animationController);
    initStartAndEndDate();
    getArgument();
    super.onInit();
  }

  void initStartAndEndDate() {
    DateTime now = DateTime.now();

    // Set startDate to the beginning of the day
    DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0, 0);

    // Set endDate to the end of the day
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    startDateController.text =
        DateUtil.formatMillisecondsToDOB(startOfDay.millisecondsSinceEpoch);
    endDateController.text =
        DateUtil.formatMillisecondsToDOB(endOfDay.millisecondsSinceEpoch);
    startDate.value = startOfDay.millisecondsSinceEpoch;
    endDate.value = endOfDay.millisecondsSinceEpoch;
  }

  void getStartDateInMilliSecond(int? date) {
    startDate.value = date;
    endDate.value = date;
    endDateController.text = DateUtil.formatMillisecondsToDOB(date ?? 0);
  }

  void getEndDateInMilliSecond(int? date) {
    endDate.value = date;
  }

  void getArgument() {
    if (Get.arguments != null) {
      if (Get.arguments["state"] == AppState.edit) {
        leave.value = Get.arguments["leave"];
        title.value = "Edit Leave";
        appState.value = AppState.edit;
        startDate.value = leave.value?.from;
        endDate.value = leave.value?.to;
        attachments.value = leave.value?.attachment ?? [];
        durationController.value.text = (leave.value?.duration ?? 1).toString();
        startDateController.text =
            DateUtil.formatMillisecondsToDOB(leave.value?.from);
        endDateController.text =
            DateUtil.formatMillisecondsToDOB(leave.value?.to);
        selectLeaveType.value = leave.value?.type ?? LeaveType.annual;
        selectLeaveDurationType.value =
            leave.value?.durationType ?? LeaveTypeDuration.fullDay;
        reasonController.text = leave.value?.reason ?? '';
      } else {
        title.value = "Add Leave";
        appState.value = AppState.create;
      }
    }
  }

  Future<void> addLeave() async {
    try {
      final result =
          await UploadFileUtil.uploadFiles(attachments.value, "leave");
      attachments.value = result;
      CreateLeaveModel input = CreateLeaveModel(
        type: selectLeaveType.value,
        durationType: selectLeaveDurationType.value,
        from: startDate.value,
        to: endDate.value,
        reason: reasonController.text,
        duration: durationController.value.text.isNotEmpty
            ? durationController.value.text.toDouble()
            : 1,
        requestDate: DateTime.now().millisecondsSinceEpoch,
        attachment: attachments.value,
      );
      await AddLeaveService().addLeave(input);
      await LeaveController.to.getUserLeave();
      LeaveController.to.getUserSummarizeLeave();
      Get.back();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response!.data["message"]);
      rethrow;
    }
  }

  Future<void> updateLeave() async {
    try {
      final result =
          await UploadFileUtil.uploadFiles(attachments.value, "leave");
      attachments.value = result;
      UpdateLeaveModel input = UpdateLeaveModel(
        type: selectLeaveType.value,
        durationType: selectLeaveDurationType.value,
        from: startDate.value,
        to: endDate.value,
        reason: reasonController.text,
        duration: durationController.value.text.isNotEmpty
            ? durationController.value.text.toDouble()
            : 1,
        attachment: attachments.value,
      );
      await AddLeaveService().updateLeave(leave.value!.id!, input);
      LeaveController.to.getUserLeave();
      Get.back();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response!.data["message"]);
      rethrow;
    }
  }
}
