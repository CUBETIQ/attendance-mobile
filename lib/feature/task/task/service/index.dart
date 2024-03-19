import 'package:timesync/core/model/summary_task_model.dart';
import 'package:timesync/core/model/task_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/types/task_status.dart';
import 'package:dio/dio.dart';
import 'package:timesync/utils/logger.dart';

class TaskService {
  static final _singleton = TaskService._internal();
  final dioInstance = DioUtil();

  factory TaskService() {
    return _singleton;
  }

  TaskService._internal() {
    Logs.t('[TaskService] Initialized');
  }

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
      "status": TaskStatus.done,
      "completedDate": DateTime.now().millisecondsSinceEpoch,
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
