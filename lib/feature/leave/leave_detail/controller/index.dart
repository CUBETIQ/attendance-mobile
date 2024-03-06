import 'package:timesync360/core/model/leave_model.dart';
import 'package:get/get.dart';
import 'package:timesync360/utils/file_util.dart';

class LeaveDetailController extends GetxController {
  static LeaveDetailController get to => Get.find();
  final leave = LeaveModel().obs;

  @override
  void onInit() {
    super.onInit();
    leave.value = Get.arguments;
  }

  bool checkExistFile(int index) {
    final fileExist = FileUtil.checkFileExist(
        fileName: leave.value.attachment?[index].name ?? "");
    return fileExist;
  }
}
