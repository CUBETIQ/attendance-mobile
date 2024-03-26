import 'package:get/get.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/model/user_model.dart';

class AttendanceStatisticController extends GetxController {
  static AttendanceStatisticController get to => Get.find();

  final appBarTitle = "Check in".obs;
  final staffs = <UserModel>[].obs;
  final attendaces = <AttendanceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initArguments();
  }

  UserModel getUser(AttendanceModel attendance) {
    return staffs.firstWhere((element) => element.id == attendance.userId);
  }

  List<AttendanceModel> removeDuplicateAttendances(
      List<AttendanceModel> attendances) {
    Set<String> userId = <String>{};
    List<AttendanceModel> uniqueAttendances = [];

    for (AttendanceModel attendance in attendances) {
      if (userId.add(attendance.userId!)) {
        uniqueAttendances.add(attendance);
      }
    }

    return uniqueAttendances;
  }

  void initArguments() {
    final data = Get.arguments;
    final List<AttendanceModel> allAttendances = Get.arguments["attendance"];
    staffs.value = data['staffs'];
    attendaces.value = removeDuplicateAttendances(allAttendances);
    appBarTitle.value = data['title'];
  }
}
