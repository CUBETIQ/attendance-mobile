import 'package:dio/dio.dart';
import 'package:timesync/core/model/earn_point_model.dart';
import 'package:timesync/core/network/dio/dio_util.dart';
import 'package:timesync/core/network/dio/endpoint.dart';
import 'package:timesync/utils/logger.dart';

class EarnPointService {
  static final _singleton = EarnPointService._internal();
  final dioInstance = DioUtil();

  factory EarnPointService() {
    return _singleton;
  }

  EarnPointService._internal() {
    Logs.t('[EarnPointService] Initialized');
  }

  Future<EarnPointModel> getEarnPoint() async {
    EarnPointModel? earnPoint;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_user_earn_point,
    );
    if (response.statusCode == 200) {
      earnPoint = EarnPointModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Get earn point failed");
    }
    return earnPoint;
  }
}
