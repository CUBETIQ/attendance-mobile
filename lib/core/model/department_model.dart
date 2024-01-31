import 'package:timesync360/core/repositories/base_model.dart';

class DepartmentModel extends BaseModel<DepartmentModel> {
  final String? id;
  final String? name;
  final String? description;
  final String? image;
  final String? organizationId;

  DepartmentModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.organizationId,
  });

  @override
  DepartmentModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return DepartmentModel();
    }
    return DepartmentModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      organizationId: json['organizationId'],
    );
  }

  @override
  List<DepartmentModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <DepartmentModel>[];
    }
    return listJson.map((e) => fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "image": image,
      "organizationId": organizationId,
    };
  }
}
