import 'package:timesync360/core/model/leave_model.dart';
import 'package:timesync360/core/widgets/debouncer/debouncer.dart';
import 'package:timesync360/core/widgets/snackbar/snackbar.dart';
import 'package:timesync360/feature/leave/add_leave/model/create_leave_model.dart';
import 'package:timesync360/feature/leave/add_leave/service/index.dart';
import 'package:timesync360/feature/leave/leave/controller/index.dart';
import 'package:timesync360/utils/time_util.dart';
import 'package:timesync360/utils/types_helper/leave_duration_type.dart';
import 'package:timesync360/utils/types_helper/leave_type.dart';
import 'package:timesync360/utils/types_helper/state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLeaveController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AddLeaveController get to => Get.find();
  RxString title = "Add Leave".obs;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  Rxn<int> startDate = Rxn<int>(null);
  Rxn<int> endDate = Rxn<int>(null);
  Rx<String> selectLeaveType = LeaveType.annual.obs;
  RxList<String> leaveTypes = [
    LeaveType.annual,
    LeaveType.sick,
  ].obs;
  RxList<String> leaveTypeDuration = [
    LeaveTypeDuration.fullDay,
    LeaveTypeDuration.halfDay,
  ].obs;
  Rx<String> selectLeaveDurationType = LeaveTypeDuration.fullDay.obs;
  late AnimationController animationController;
  late Animation<double> sizeAnimation;
  late Animation<Color?> colorAnimation;
  RxString appState = AppState.Create.obs;
  Rxn<LeaveModel> leave = Rxn<LeaveModel>(null);
  final _debouncer = Debouncer(milliseconds: 500);

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

    startDateController.text = DateFormatter()
        .formatMillisecondsToDOB(startOfDay.millisecondsSinceEpoch);
    endDateController.text = DateFormatter()
        .formatMillisecondsToDOB(endOfDay.millisecondsSinceEpoch);
    startDate.value = startOfDay.millisecondsSinceEpoch;
    endDate.value = endOfDay.millisecondsSinceEpoch;
  }

  void getStartDateInMilliSecond(int? date) {
    startDate.value = date;
    endDate.value = date;
    endDateController.text = DateFormatter().formatMillisecondsToDOB(date ?? 0);
  }

  void getEndDateInMilliSecond(int? date) {
    endDate.value = date;
  }

  void onChnageLeaveDurationType(int index) {
    // Reset the animation before starting it
    animationController.reset();
    // Start the animation
    animationController.reverse();
    selectLeaveDurationType.value = leaveTypeDuration[index];
  }

  void getArgument() {
    if (Get.arguments != null) {
      if (Get.arguments["state"] == AppState.Edit) {
        leave.value = Get.arguments["leave"];
        title.value = "Edit Leave";
        appState.value = AppState.Edit;
        startDate.value = leave.value?.from;
        endDate.value = leave.value?.to;
        startDateController.text =
            DateFormatter().formatMillisecondsToDOB(leave.value?.from);
        endDateController.text =
            DateFormatter().formatMillisecondsToDOB(leave.value?.to);
        selectLeaveType.value = leave.value?.type ?? LeaveType.annual;
        selectLeaveDurationType.value =
            leave.value?.durationType ?? LeaveTypeDuration.fullDay;
        reasonController.text = leave.value?.reason ?? '';
      } else {
        title.value = "Add Leave";
        appState.value = AppState.Create;
      }
    }
  }

  Future<void> addLeave() async {
    _debouncer.run(() async {
      try {
        CreateLeaveModel input = CreateLeaveModel(
          type: selectLeaveType.value,
          durationType: selectLeaveDurationType.value,
          from: startDate.value,
          to: endDate.value,
          reason: reasonController.text,
        );
        await AddLeaveService().addLeave(input);
        await LeaveController.to.getUserLeave();
        LeaveController.to.getUserSummarizeLeave();
        Get.back();
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response!.data["message"]);
        rethrow;
      }
    });
  }

  Future<void> updateLeave() async {
    _debouncer.run(() async {
      try {
        CreateLeaveModel input = CreateLeaveModel(
          type: selectLeaveType.value,
          durationType: selectLeaveDurationType.value,
          from: startDate.value,
          to: endDate.value,
          reason: reasonController.text,
        );
        await AddLeaveService().updateLeave(leave.value!.id!, input);
        LeaveController.to.getUserLeave();
        Get.back();
      } on DioException catch (e) {
        showErrorSnackBar("Error", e.response!.data["message"]);
        rethrow;
      }
    });
  }
}
