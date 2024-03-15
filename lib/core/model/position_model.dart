import 'package:timesync/core/repositories/base_model.dart';

class PositionModel extends BaseModel<PositionModel> {
  final String? id;
  final String? name;
  final String? description;
  final String? image;
  final String? organizationId;
  final String? departmentId;

  PositionModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.organizationId,
    this.departmentId,
  });

  @override
  PositionModel fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return PositionModel();
    }
    return PositionModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      organizationId: json['organizationId'],
      departmentId: json['departmentId'],
    );
  }

  @override
  List<PositionModel> fromListJson(List? listJson) {
    if (listJson == null) {
      return <PositionModel>[];
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
      "departmentId": departmentId,
    };
  }
}
