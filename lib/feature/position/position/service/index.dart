import 'package:timesync/core/model/position_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:timesync/utils/logger.dart';

class PositionService {
  static final _singleton = PositionService._internal();
  final dioInstance = DioUtil();

  factory PositionService() {
    return _singleton;
  }

  PositionService._internal() {
    Logs.t('[PositionService] Initialized');
  }

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
