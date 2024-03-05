import 'package:timesync360/core/model/task_model.dart';
import 'package:get/get.dart';
import 'package:timesync360/utils/file_util.dart';

class TaskDetailController extends GetxController {
  static TaskDetailController get to => Get.find();
  final task = Rxn<TaskModel>(null);
  final progress = 0.0.obs;
  final isDownloading = false.obs;
  final fileExist = false.obs;

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  void getArgument() {
    task.value = Get.arguments["task"];
  }

  bool checkExistFile(int index) {
    final fileExist = FileUtil.checkFileExist(
        fileName: task.value?.attachment?[index].name ?? "");
    return fileExist;
  }
}
