import 'package:attendance_app/core/model/leave_model.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/leave/service/index.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LeaveController extends GetxController {
  static LeaveController get to => Get.find();
  RxList<LeaveModel> leave = <LeaveModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getLeave();
  }

  Future<void> getLeave() async {
    isLoading.value = true;
    try {
      leave.value = await LeaveService().getLeave();
    } on DioException catch (e) {
      isLoading.value = false;
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
