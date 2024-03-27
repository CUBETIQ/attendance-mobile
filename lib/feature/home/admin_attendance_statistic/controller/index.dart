import 'package:get/get.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/model/user_model.dart';

class AttendanceStatisticController extends GetxController {
  static AttendanceStatisticController get to => Get.find();

  final appBarTitle = "Check-out".obs;
  final staffs = <UserModel>[].obs;
  final attendances = <AttendanceModel>[].obs;
  final backUpAttendaces = <AttendanceModel>[].obs;
  final positions = <PositionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initArguments();
  }

  List<UserModel> getUser() {
    List<UserModel> staff = [];
    for (var element in attendances) {
      staff.add(staffs.firstWhere((staff) => staff.id == element.userId));
    }
    return staff;
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
    backUpAttendaces.value = Get.arguments["attendance"];
    staffs.value = data['staffs'];
    attendances.value = removeDuplicateAttendances(backUpAttendaces.value);
    appBarTitle.value = data['title'];
    positions.value = data['positions'];
  }
}
