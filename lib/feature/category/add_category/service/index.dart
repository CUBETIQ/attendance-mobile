import 'package:dio/dio.dart';
import 'package:timesync360/core/model/category_model.dart';
import 'package:timesync360/core/network/endpoint.dart';
import 'package:timesync360/feature/category/add_category/model/create_category_model.dart';
import '../../../../core/network/dio_util.dart';

class AddCategoryService {
  DioUtil dioInstance = DioUtil();

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
}
