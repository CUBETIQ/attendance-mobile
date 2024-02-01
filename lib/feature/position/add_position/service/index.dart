import 'package:dio/dio.dart';
import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:timesync360/feature/position/add_position/model/add_position_model.dart';
import 'package:timesync360/feature/position/add_position/model/edit_position_model.dart';

class AddPositionService {
  DioUtil dioInstance = DioUtil();

  Future<PositionModel> addPosition(AddPositionModel input) async {
    final PositionModel position;
    Map<String, dynamic> inputData = input.toJson();
    Response response = await dioInstance.dio.post(
      Endpoints.instance.get_position,
      data: inputData,
    );
    if (response.statusCode == 201) {
      position = PositionModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Add position failed");
    }
    return position;
  }

  Future<void> updatePosition(String id, EditPositionModel input) async {
    Map<String, dynamic> inputData = input.toJson();
    Response response = await dioInstance.dio.put(
      Endpoints.instance.get_position + id,
      data: inputData,
    );
    if (response.statusCode != 200) {
      throw Exception("Update position failed");
    }
  }
}