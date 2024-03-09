import 'package:timesync/core/repositories/base_model.dart';

class CategoryModel extends BaseModel<CategoryModel> {
  final String? id;
  final String? name;
  final String? description;
  final String? type;
  final String? icon;
  final String? color;
  final String? organizationId;
  final String? createdBy;
  final bool? enabled;

  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.color,
    this.type,
    this.organizationId,
    this.createdBy,
    this.enabled,
  });

  @override
  CategoryModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return CategoryModel();
    }
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      color: json['color'],
      type: json['type'],
      organizationId: json['organizationId'],
      createdBy: json['createdBy'],
      enabled: json['enabled'],
    );
  }

  @override
  List<CategoryModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <CategoryModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "icon": icon,
      "color": color,
      "type": type,
      "organizationId": organizationId,
      "createdBy": createdBy,
      "enabled": enabled,
    };
  }
}
