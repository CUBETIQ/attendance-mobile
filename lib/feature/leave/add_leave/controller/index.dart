import 'package:attendance_app/core/model/leave_model.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/leave/add_leave/model/create_leave_model.dart';
import 'package:attendance_app/feature/leave/add_leave/service/index.dart';
import 'package:attendance_app/feature/leave/leave/controller/index.dart';
import 'package:attendance_app/utils/time_formater.dart';
import 'package:attendance_app/utils/types_helper/leave_duration_type.dart';
import 'package:attendance_app/utils/types_helper/leave_type.dart';
import 'package:attendance_app/utils/types_helper/state.dart';
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
    startDateController.text =
        DateFormatter().formatMillisecondsToDOB(now.millisecondsSinceEpoch);
    endDateController.text =
        DateFormatter().formatMillisecondsToDOB(now.millisecondsSinceEpoch);
    startDate.value = now.millisecondsSinceEpoch;
    endDate.value = now.millisecondsSinceEpoch;
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
        startDate.value = leave.value?.leaveFrom;
        endDate.value = leave.value?.leaveTo;
        startDateController.text =
            DateFormatter().formatMillisecondsToDOB(leave.value?.leaveFrom);
        endDateController.text =
            DateFormatter().formatMillisecondsToDOB(leave.value?.leaveTo);
        selectLeaveType.value = leave.value?.leaveType ?? LeaveType.annual;
        selectLeaveDurationType.value =
            leave.value?.leaveDurationType ?? LeaveTypeDuration.fullDay;
        reasonController.text = leave.value?.leaveReason ?? '';
      } else {
        title.value = "Add Leave";
        appState.value = AppState.Create;
      }
    }
  }

  Future<void> addLeave() async {
    try {
      CreateLeaveModel input = CreateLeaveModel(
        leaveType: selectLeaveType.value,
        leaveDurationType: selectLeaveDurationType.value,
        leaveFrom: startDate.value,
        leaveTo: endDate.value,
        leaveReason: reasonController.text,
      );
      await AddLeaveService().addLeave(input);
      LeaveController.to.getOwnLeave();
      Get.back();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response!.data["message"]);
      rethrow;
    }
  }

  Future<void> updateLeave() async {
    try {
      CreateLeaveModel input = CreateLeaveModel(
        leaveType: selectLeaveType.value,
        leaveDurationType: selectLeaveDurationType.value,
        leaveFrom: startDate.value,
        leaveTo: endDate.value,
        leaveReason: reasonController.text,
      );
      await AddLeaveService().updateLeave(leave.value!.id!, input);
      LeaveController.to.getOwnLeave();
      Get.back();
    } on DioException catch (e) {
      showErrorSnackBar("Error", e.response!.data["message"]);
      rethrow;
    }
  }
}
