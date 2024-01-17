import 'package:attendance_app/core/model/summary_task_model.dart';
import 'package:attendance_app/core/model/task_model.dart';
import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/utils/types_helper/task_status.dart';
import 'package:dio/dio.dart';

class TaskService {
  DioUtil dioInstance = DioUtil();

  Future<List<TaskModel>> getUserTasks({int? startDate, int? endDate}) async {
    final List<TaskModel> tasks;
    Map<String, dynamic> queryParameters = {
      "startDate": startDate,
      "endDate": endDate,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_user_task,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      tasks = TaskModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get task failed");
    }
    return tasks;
  }

  Future<List<SummaryTaskModel>> getUserTaskSummarize(
      {int? startDate, int? endDate}) async {
    final List<SummaryTaskModel> summaryTasks;

    Map<String, dynamic> queryParameters = {
      "startDate": startDate,
      "endDate": endDate,
    };

    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_user_task_summarize,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      summaryTasks = SummaryTaskModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get task failed");
    }
    return summaryTasks;
  }

  Future<void> completeTask(String id) async {
    Map<String, dynamic> data = {
      "status": TaskStatus.completed,
    };

    Response response = await dioInstance.dio.put(
      Endpoints.instance.complete_task + id,
      data: data,
    );

    if (response.statusCode != 200) {
      throw Exception("Complete task failed");
    }
  }

  Future<void> deleteTask(String id) async {
    Response response = await dioInstance.dio.delete(
      Endpoints.instance.task + id,
    );
    if (response.statusCode != 200) {
      throw Exception("Delete task failed");
    }
  }
}
