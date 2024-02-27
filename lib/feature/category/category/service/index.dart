import 'package:dio/dio.dart';
import 'package:timesync360/core/model/category_model.dart';
import 'package:timesync360/core/network/dio/dio_util.dart';
import 'package:timesync360/core/network/dio/endpoint.dart';
import 'package:timesync360/utils/logger.dart';

class CategoryService {
  static final _singleton = CategoryService._internal();
  final dioInstance = DioUtil();

  factory CategoryService() {
    return _singleton;
  }

  CategoryService._internal() {
    Logs.t('[CategoryService] Initialized');
  }

  Future<List<CategoryModel>> getAllCategory(String orgnaizationId) async {
    final List<CategoryModel>? categories;
    final queryParam = {
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

  Future<void> deleteCategory(String id) async {
    Response response = await dioInstance.dio.delete(
      Endpoints.instance.category + id,
    );
    if (response.statusCode != 200) {
      throw Exception("Delete category failed");
    }
  }
}
