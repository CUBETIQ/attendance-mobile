import 'package:get/get.dart';
import 'package:timesync/core/model/attendance_model.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/utils/logger.dart';

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

  void initArguments() {
    final data = Get.arguments;
    staffs.value = data['staffs'];
    attendaces.value = data['attendance'];
    appBarTitle.value = data['title'];
    Logs.e("staffs: ${staffs.length}");
    Logs.e("attendance: ${attendaces.length}");
    Logs.e("title: $appBarTitle");
  }
}
