import 'package:attendance_app/core/model/attendance_model.dart';
import 'package:attendance_app/core/model/user_model.dart';
import 'package:get/get.dart';

class SummaryAttendanceController extends GetxController {
  static SummaryAttendanceController get to => Get.find();
  RxList<AttendanceModel> staffAttendanceList = <AttendanceModel>[].obs;
  RxList<UserModel> staffs = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  void getArgument() {
    staffs.value = Get.arguments["staffs"];
    staffAttendanceList.value = Get.arguments["attendances"];
  }

  // Function to get attendance details for a staff member
  List<UserModel> getStaffForAttendance(AttendanceModel atttendance) {
    return staffs.where((element) => element.id == atttendance.userId).toList();
  }
}
