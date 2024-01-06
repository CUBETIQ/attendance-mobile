import 'package:attendance_app/core/model/user_model.dart';
import 'package:attendance_app/core/widgets/snackbar/snackbar.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/feature/staff/staff/service/index.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class StaffController extends GetxController {
  static StaffController get to => Get.find();
  RxList<UserModel> staffs = <UserModel>[].obs;
  RxString organizationId = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    organizationId.value = NavigationController.to.organization.value.id ?? "";
    getAllStaffs();
  }

  Future<void> getAllStaffs() async {
    isLoading.value = true;
    try {
      staffs.value = await StaffService()
          .getAllStaffs(organizationId: organizationId.value);
    } on DioException catch (e) {
      isLoading.value = false;
      showErrorSnackBar("Error", e.response?.data["message"]);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
