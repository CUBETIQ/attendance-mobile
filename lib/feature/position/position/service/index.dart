import 'package:timesync360/core/model/position_model.dart';
import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:dio/dio.dart';

class PositionService {
  DioUtil dioInstance = DioUtil();

  Future<List<PositionModel>> getAllPosition(
      {required String organizationId}) async {
    final List<PositionModel>? positions;
    final Map<String, dynamic> queryParameters = {
      "organizationId": organizationId,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_position,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      positions = PositionModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get All Position failed");
    }
    return positions;
  }

  Future<void> deletePosition(String id) async {
    Response response = await dioInstance.dio.delete(
      Endpoints.instance.get_position + id,
    );
    if (response.statusCode != 200) {
      throw Exception("Delete position failed");
    }
  }
}
