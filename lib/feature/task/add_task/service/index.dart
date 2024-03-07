import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/feature/task/add_task/model/create_task_model.dart';
import 'package:dio/dio.dart';
import 'package:timesync/utils/logger.dart';

class AddTaskService {
  static final _singleton = AddTaskService._internal();
  final dioInstance = DioUtil();

  factory AddTaskService() {
    return _singleton;
  }

  AddTaskService._internal() {
    Logs.t('[AddTaskService] Initialized');
  }

  Future<void> addTask(CreateTaskModel input) async {
    Map<String, dynamic> data = input.toJson();
    Response response = await dioInstance.dio.post(
      Endpoints.instance.task,
      data: data,
    );
    if (response.statusCode != 201) {
      throw Exception("Add task failed");
    }
  }

  Future<void> updateTask(String id, CreateTaskModel input) async {
    Map<String, dynamic> data = input.toJson();

    Response response = await dioInstance.dio.put(
      Endpoints.instance.task + id,
      data: data,
    );
    if (response.statusCode != 200) {
      throw Exception("Update task failed");
    }
  }
}
