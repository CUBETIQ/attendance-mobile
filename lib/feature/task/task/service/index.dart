import 'package:attendance_app/core/model/task_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/utils/types_helper/task_status.dart';
import 'package:dio/dio.dart';

class TaskService {
  DioUtil dioInstance = DioUtil();

  Future<List<TaskModel>> getUserTasks() async {
    final List<TaskModel> tasks;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_own_task,
    );
    if (response.statusCode == 200) {
      tasks = TaskModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get task failed");
    }
    return tasks;
  }

  Future<void> completeTask(String id) async {
    Response response = await dioInstance.dio.put(
        Endpoints.instance.complete_task + id,
        data: {"taskStatus": TaskStatus.completed});
    if (response.statusCode != 200) {
      throw Exception("Complete task failed");
    }
  }

  // Future<void> addTask(CreateTaskModel input) async {
  //   final data = {
  //     "taskName": input.taskName,
  //     "taskDescription": input.taskDescription,
  //     "taskType": input.taskType,
  //     "startDate": input.startDate,
  //     "endDate": input.endDate
  //   };

  //   Response response = await dioInstance.dio.post(
  //     Endpoints.instance.task,
  //     data: data,
  //   );
  //   if (response.statusCode != 200) {
  //     throw Exception("Add task failed");
  //   }
  // }
}
