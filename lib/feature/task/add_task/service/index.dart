import 'package:attendance_app/core/network/dio_util.dart';
import 'package:attendance_app/core/network/endpoint.dart';
import 'package:attendance_app/feature/task/add_task/model/create_task_model.dart';
import 'package:dio/dio.dart';

class AddTaskService {
  DioUtil dioInstance = DioUtil();

  Future<void> addTask(CreateTaskModel input, int date) async {
    Map<String, dynamic> data = {
      "taskName": input.taskName,
      "taskDescription": input.taskDescription,
      "startDate": input.startDate,
      "endDate": input.endDate,
      "color": input.color,
      "icon": input.icon,
      "date": date,
    };

    Response response = await dioInstance.dio.post(
      Endpoints.instance.task,
      data: data,
    );
    if (response.statusCode != 200) {
      throw Exception("Add task failed");
    }
  }

  Future<void> updateTask(String id, CreateTaskModel input) async {
    final data = {
      "taskName": input.taskName,
      "taskDescription": input.taskDescription,
      "startDate": input.startDate,
      "endDate": input.endDate,
      "color": input.color,
      "icon": input.icon,
    };

    Response response = await dioInstance.dio.put(
      Endpoints.instance.task + id,
      data: data,
    );
    if (response.statusCode != 200) {
      throw Exception("Update task failed");
    }
  }
}
