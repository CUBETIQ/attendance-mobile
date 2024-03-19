import 'package:timesync/core/model/task_model.dart';
import 'package:get/get.dart';
import 'package:timesync/core/model/user_model.dart';
import 'package:timesync/utils/file_util.dart';

class TaskDetailController extends GetxController {
  static TaskDetailController get to => Get.find();
  final task = Rxn<TaskModel>(null);
  final user = Rxn<UserModel>(null);
  final progress = 0.0.obs;
  final isDownloading = false.obs;
  final fileExist = false.obs;
  final argument = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  void getArgument() {
    task.value = argument["task"];
    if (argument["user"] != null) {
      user.value = argument["user"];
    }
  }

  bool checkExistFile(int index) {
    final fileExist = FileUtil.checkFileExist(
        fileName: task.value?.attachment?[index].name ?? "");
    return fileExist;
  }
}
