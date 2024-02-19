import 'package:dio/dio.dart';
import 'package:timesync360/core/model/category_model.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:timesync360/feature/category/add_category/model/create_category_model.dart';
import 'package:timesync360/feature/category/add_category/model/update_category_model.dart';
import 'package:timesync360/utils/logger.dart';
import '../../../../core/network/dio_util.dart';

class AddCategoryService {
  static final _singleton = AddCategoryService._internal();
  final dioInstance = DioUtil();

  factory AddCategoryService() {
    return _singleton;
  }

  AddCategoryService._internal() {
    Logs.t('[AddCategoryService] Initialized');
  }

  Future<List<String>> getCategoryType() async {
    final List<String> categoryTypes;
    Response response = await dioInstance.dio.get(
      Endpoints.instance.categoryType,
    );
    if (response.statusCode == 200) {
      categoryTypes = List<String>.from(response.data["data"]);
    } else {
      throw Exception("Get category type failed");
    }
    return categoryTypes;
  }

  Future<CategoryModel> addCategory(CreateCategoryModel input) async {
    final CategoryModel category;
    Map<String, dynamic> body = input.toJson();
    Response response = await dioInstance.dio.post(
      Endpoints.instance.category,
      data: body,
    );
    if (response.statusCode == 201) {
      category = CategoryModel().fromJson(response.data["data"]);
    } else {
      throw Exception("Add category failed");
    }
    return category;
  }

  Future<void> updateCategory(String id, UpdateCategoryModel input) async {
    Map<String, dynamic> body = input.toJson();
    Response response = await dioInstance.dio.put(
      Endpoints.instance.category + id,
      data: body,
    );
    if (response.statusCode != 200) {
      throw Exception("Update category failed");
    }
  }
}
