class AddPositionModel {
  final String? name;
  final String? description;
  final String? image;
  final String? organizationId;
  final String? departmentId;

  AddPositionModel({
    this.name,
    this.description,
    this.image,
    this.organizationId,
    this.departmentId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "image": image,
      "organizationId": organizationId,
      "departmentId": departmentId,
    };
  }
}
