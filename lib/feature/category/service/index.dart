import 'package:dio/dio.dart';
import 'package:timesync360/core/model/category_model.dart';
import 'package:timesync360/core/network/dio_util.dart';
import 'package:timesync360/core/network/endpoint.dart';

class CategoryService {
  DioUtil dioInstance = DioUtil();

  Future<List<CategoryModel>> getAllCategory(String orgnaizationId) async {
    final List<CategoryModel>? categories;
    Map<String, dynamic> queryParam = {
      "organizationId": orgnaizationId,
    };
    Response response = await dioInstance.dio.get(
      Endpoints.instance.category,
      queryParameters: queryParam,
    );
    if (response.statusCode == 200) {
      categories = CategoryModel().fromListJson(response.data["data"]);
    } else {
      throw Exception("Get all category failed");
    }
    return categories;
  }
}
