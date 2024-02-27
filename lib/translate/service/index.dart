import 'package:timesync360/core/network/dio/dio_util.dart';
import 'package:timesync360/core/network/dio/endpoint.dart';
import 'package:dio/dio.dart';

class TranslateService {
  DioUtil dioInstance = DioUtil();

  Future<Map<String, String>> getTranslate({required String param}) async {
    Map<String, String> lang = {};
    Map<String, String> queryParameters = {
      "lang": param,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.get_translation,
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      lang = Map<String, String>.from(response.data['data']);
    } else {
      throw Exception("Failed to get staff report");
    }
    return lang;
  }
}
